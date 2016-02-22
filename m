Sender: Michael Welling <mwelling79@gmail.com>
Date: Mon, 22 Feb 2016 17:50:18 -0600
From: Michael Welling <mwelling@ieee.org>
Message-ID: <20160222235018.GA30318@deathstar>
References: <1456184548-30058-1-git-send-email-mwelling@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456184548-30058-1-git-send-email-mwelling@ieee.org>
Subject: Re: [Xenomai] [PATCH] demo/alchemy/cross-link: Properly handle
	syscall errors
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, Lowell Gilbert <kludge@be-well.ilk.org>

On Mon, Feb 22, 2016 at 05:42:28PM -0600, Michael Welling wrote:
> Update cross link demo to properly handle errors returned from syscalls.
> 
> Signed-off-by: Michael Welling <mwelling@ieee.org>
> ---
>  demo/alchemy/cobalt/cross-link.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/demo/alchemy/cobalt/cross-link.c b/demo/alchemy/cobalt/cross-link.c
> index 8c0f53f..dceb928 100644
> --- a/demo/alchemy/cobalt/cross-link.c
> +++ b/demo/alchemy/cobalt/cross-link.c
> @@ -23,6 +23,7 @@
>  #include <stdio.h>
>  #include <signal.h>
>  #include <unistd.h>
> +#include <errno.h>
>  #include <sys/mman.h>
>  #include <alchemy/task.h>
>  #include <alchemy/timer.h>
> @@ -78,8 +79,8 @@ static int close_file( int fd, char *name)
>  	do {
>  		i++;
>  		err = close(fd);
> -		switch (err) {
> -		case -EAGAIN:
> +		switch (errno) {
> +		case EAGAIN:
>  			printf(MAIN_PREFIX "%s -> EAGAIN (%d times)\n",
>  			       name, i);
>  			rt_task_sleep(50000); /* wait 50us */
> @@ -89,10 +90,10 @@ static int close_file( int fd, char *name)
>  			break;
>  		default:
>  			printf(MAIN_PREFIX "%s -> %s\n", name,
> -			       strerror(-err));
> +			       strerror(errno));
>  			break;
>  		}
> -	} while (err == -EAGAIN && i < 10);
> +	} while (errno == EAGAIN && i < 10);
>  
>  	return err;

Missed the return code here.

>  }
> @@ -158,7 +159,7 @@ static void write_task_proc(void *arg)
>  		written = write(write_fd, &write_time, sz);
>  		if (written < 0 ) {
>  			printf(WTASK_PREFIX "error on write, %s\n",
> -			       strerror(-err));
> +			       strerror(errno));
>  			break;
>  		} else if (written != sz) {
>  			printf(WTASK_PREFIX "only %d / %zd byte transmitted\n",
> @@ -201,8 +202,8 @@ static void read_task_proc(void *arg)
>  		if (err) {
>  			printf(RTASK_PREFIX
>  			       "error on RTSER_RTIOC_WAIT_EVENT, %s\n",
> -			       strerror(-err));
> -			if (err == -ETIMEDOUT)
> +			       strerror(errno));
> +			if (err == ETIMEDOUT)

This should be if (errno == ETIMEDOUT)

>  				continue;
>  			break;
>  		}
> @@ -218,7 +219,7 @@ static void read_task_proc(void *arg)
>  			nr++;
>  		} else if (rd < 0 ) {
>  			printf(RTASK_PREFIX "error on read, code %s\n",
> -			       strerror(-err));
> +			       strerror(errno));
>  			break;
>  		} else {
>  			printf(RTASK_PREFIX "only %d / %zd byte received \n",
> @@ -245,7 +246,7 @@ int main(int argc, char* argv[])
>  	write_fd = open( WRITE_FILE, 0);
>  	if (write_fd < 0) {
>  		printf(MAIN_PREFIX "can't open %s (write), %s\n", WRITE_FILE,
> -		       strerror(-write_fd));
> +		       strerror(errno));
>  		goto error;
>  	}
>  	write_state |= STATE_FILE_OPENED;
> @@ -255,7 +256,7 @@ int main(int argc, char* argv[])
>  	err = ioctl(write_fd, RTSER_RTIOC_SET_CONFIG, &write_config);
>  	if (err) {
>  		printf(MAIN_PREFIX "error while RTSER_RTIOC_SET_CONFIG, %s\n",
> -		       strerror(-err));
> +		       strerror(errno));
>  		goto error;

Seems I forgot to consider the return code after the jump.

Here comes v2.

>  	}
>  	printf(MAIN_PREFIX "write-config written\n");
> @@ -264,7 +265,7 @@ int main(int argc, char* argv[])
>  	read_fd = open( READ_FILE, 0 );
>  	if (read_fd < 0) {
>  		printf(MAIN_PREFIX "can't open %s (read), %s\n", READ_FILE,
> -		       strerror(-read_fd));
> +		       strerror(errno));
>  		goto error;
>  	}
>  	read_state |= STATE_FILE_OPENED;
> @@ -274,7 +275,7 @@ int main(int argc, char* argv[])
>  	err = ioctl(read_fd, RTSER_RTIOC_SET_CONFIG, &read_config);
>  	if (err) {
>  		printf(MAIN_PREFIX "error while ioctl, %s\n",
> -		       strerror(-err));
> +		       strerror(errno));
>  		goto error;
>  	}
>  	printf(MAIN_PREFIX "read-config written\n");
> -- 
> 2.1.4
> 

