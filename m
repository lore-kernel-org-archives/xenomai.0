From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17545.26998.683843.924195@domain.hid>
Date: Fri, 9 Jun 2006 14:28:38 +0200
Subject: Re: [Xenomai-help] shm_open, ftruncate
In-Reply-To: <448937A5.7080701@domain.hid>
References: <4480595D.7040203@domain.hid>
	<17536.29324.723709.385494@domain.hid>
	<4484365A.7090007@domain.hid>
	<17540.21517.871383.751462@domain.hid>
	<44856CA7.30802@domain.hid>
	<17541.29542.312486.329018@domain.hid>
	<44859C28.3090600@domain.hid>
	<17541.49945.431732.834139@domain.hid>
	<4486CCDF.2070409@domain.hid>
	<17542.59422.109900.142889@domain.hid>
	<448937A5.7080701@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Lionel Perrin <perrin@domain.hid>
Cc: xenomai@xenomai.org

Lionel Perrin wrote:
 > // 	/* the following lines shouldn't be commented but xenomai... */
 > // 	else
 > // 	{
 > // 		/* a new shm_file has been created, we need to truncate it */
 > // 		if (ftruncate(h_shm, nbvalues * sizeof(double))==-1)
 > // 		{
 > // 			printf("truncate failed\n");
 > // 			goto close_and_unlink;
 > // 		}
 > // 	}

Do you still have an issue with ftruncate ? 

Note that it is better to always call ftruncate even in a process that
is not creating the shared memory, this avoid the race condition where
the process that created the shared memory is about to truncate it and
is interrupted by the second process which did not create it but want to
mmap it.

 > 	mem->h_mut = (pthread_mutex_t *)malloc(sizeof(pthread_mutex_t));
 > 	pthread_mutex_init(mem->h_mut, NULL);


Note that if you want to share the mem structure between several
processes, you should put the mutex on the shared memory, doing for
example:

typedef struct {
    pthread_mutex_t mutex;
    int nbaccess;
    double values[0]
} myshm_t;

myshm_t *myshm;

myshm = (myshm_t *) mmap(...);

mem->h_mut = &myshm->mutex;
mem->ptr = &myshm->values;

pthread_mutex_init(mem->h_mut, NULL);

Xenomai should detect that you are initializing a mutex that was already
initialized and return EBUSY that you can safely ignore.

-- 


					    Gilles Chanteperdrix.

