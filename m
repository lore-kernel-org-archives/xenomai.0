Date: Wed, 21 Jun 2006 11:58:02 +0200
Message-Id: <216537120@domain.hid>
MIME-Version: 1.0
From: =?iso-8859-15?Q?Tobias_B=E4r?= <Tobias.Baer@domain.hid>
Subject: Re: [Xenomai-help] mutex locking
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


> Try this, it's safe from such races:
> 
> /* returns -EWOULDBLOCK if the mutex is locked */
> if (rt_mutex_lock(&write_mutex,TM_NONBLOCK) == 0)
> {
>       // do sth.
> 
>       rt_mutex_unlock(&mutex);
> }

Thank's for the quick reply! But another question: How could it be that a mutex is locked twice?

if(rt_mutex_lock(&write_mutex,TM_NONBLOCK) == 0)
  {
    if(rt_mutex_lock(&write_mutex,TM_NONBLOCK) == 0)
      printf("Mutex is locked twice!\n");

   rt_mutex_unlock(&mutex);
  }

Is it locked by the ID of the thread?

Tobias



