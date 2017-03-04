MIME-Version: 1.0
From: Josh Bowman <jbowman@facts-inc.com>
Date: Fri, 3 Mar 2017 21:30:18 -0500
Message-ID: <CAGTNcBuw2Wm6J1XZ2NKesomYojKZg_jxjDjw0QBncyfHDRjwNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] heap corruption with multiple,
	differently-sized calls to rt_queue_alloc()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I'm having a problem when trying to allocate multiple blocks using
rt_queue_alloc(). When my client code is building a message to send to
queue, it sometimes finds that it needs a bigger block. So it creates a new
block via rt_queue_alloc(); copies the data from the previous block into
the new block; and then calls rt_queue_free() on the old block.

The code included here is a simplified version of this process. It
allocates a buffer; puts some data in it; allocates a new buffer; and then
checks to make sure the previous buffer is intact. Then it frees the
previous buffer and loops.

When I run this code, it prints:

ERROR: at 7, 2: after rt_queue_alloc, checkMessage failed at loc 480

This means the buffer previously returned by rt_queue_alloc() is damaged by
the next call to rt_queue_alloc().  I set a watch in the debugger, and it
looks like the damage is done at line 376 of lib/alchemy/queue.c; this
seems to indicate the heapobj_alloc() is returning a region that overlaps
the one previously allocated.

I'm running Xenomai/mercury from stable-3.0.x on x86_64, with config:
"--with-core=mercury --enable-smp --enable-pshared --enable-registry
--enable-debug"

I build the test program with:

g++ queue-2.cpp -o queue-2 -g -fno-default-inline -fno-omit-frame-pointer
`xeno-config --skin=alchemy --cflags --no-auto-init --ldflags`

Changing the realloc_count parameter causes the code to fail at different
iterations; passing realloc_count = 3 moves the failure to the
rt_queue_send() call. (The code runs to completion with realloc_count set
to 1 or 2.)

I've also found that if I don't call rt_queue_free() the code runs to
completion.

Let me know if there's anything I can do to help.

Thanks,
Josh

File queue-2.cpp follows:

#include <alchemy/task.h>
#include <alchemy/queue.h>
#include <xenomai/init.h>
#include <stdio.h>
#include <stdlib.h>
#include <vector>

RT_TASK task;
RT_QUEUE queue;

void buildMessage( char * p, int len ) {
    for ( int i = 0; i < len; i++ )
        p[i] = (char)i;
}
int checkMessage( char * p, int len ) {
    for ( int i = 0; i < len; i++ )
        if ( p[i] != ((char)i))
            return i;
    return -1;
}

int main(int argc, char *const argv[]) {
    int priority = 12;
    int queueSize = 50;
    int realloc_count = 5;

    xenomai_init(&argc,&argv);

    if ( argc >= 2 )
        realloc_count = atoi( argv[1] );

    int err = rt_task_shadow( &task, "queueTask", priority, 0 );

    if ( err != 0 ) {
        fprintf( stderr, "ERROR: got %d from rt_task_shadow()\n", err );
        return 2;
    }

    err = rt_queue_create(&queue, "queue", queueSize * 16384, queueSize,
Q_FIFO );
    if ( err != 0 ) {
        fprintf( stderr, "ERROR: got %d (%s) from rt_queue_create()\n",
err, strerror( -err ) );
        return 3;
    }

    for (int i = 0; i < 40; i++) {
        int size = 256;
        char * msg = 0;
        for ( int j = 0; j < (i % realloc_count + 1); j++ ) {
            int newSize = size << 1;
            char *newMsg = (char *)rt_queue_alloc( &queue, newSize );
            if ( newMsg == 0 ) {
                fprintf( stderr, "ERROR: at %d, %d: got 0 from
rt_queue_alloc(,%d)\n", i, j, newSize );
                return 4;
            }
            if ( msg != 0 ) {
                int loc = checkMessage( msg, size );
                if ( loc >= 0 ) {
                    fprintf( stderr, "ERROR: at %d, %d: after
rt_queue_alloc, checkMessage failed at loc %d\n", i, j, loc );
                    return 4;
                }
                err = rt_queue_free( &queue, msg );
                if ( err < 0 ) {
                    fprintf( stderr, "ERROR: got %d (%s) from
rt_queue_free()\n", err, strerror(-err) );
                    return 5;
                }
            }
            msg = newMsg;
            size = newSize;
            buildMessage( msg, size );
        }

        err = rt_queue_send( &queue, msg, size, Q_NORMAL );
        if ( err < 0 ) {
            fprintf( stderr, "ERROR: at %d, got %d (%s) from
rt_queue_send()\n", i, err, strerror(-err) );
            break;
        }
    }
    return 0;
}
