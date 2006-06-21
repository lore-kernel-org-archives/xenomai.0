Date: Wed, 21 Jun 2006 11:37:38 +0200
Message-Id: <216509776@domain.hid>
MIME-Version: 1.0
From: =?iso-8859-15?Q?Tobias_B=E4r?= <Tobias.Baer@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] mutex locking
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

Hi all,

my question is about the right way to lock and inquire a mutex. At time, my code looks like this:


rt_mutex_inquire(&mutex,TM_NONBLOCK);

if(info.lockcnt == 0) 
{
      rt_mutex_lock(&write_mutex,TM_NONBLOCK);

      // do sth.

      rt_mutex_unlock(&mutex);
}


What happens if anyone locks the mutex between my "rt_mutex_inquire(...)" and my "if(info.lockcnt == 0)" ?

Is this the standard way to lock and inquire a mutex?

Thanks,
  Tobias

