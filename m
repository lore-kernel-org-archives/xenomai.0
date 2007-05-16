Message-ID: <e2ceda030705160953h27bc4033q4c2ccdba6b65bc7@domain.hid>
Date: Wed, 16 May 2007 18:53:55 +0200
From: "Maciek Godek" <pstrychuj@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] Getting mutex state/rt <-> non-rt communication
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

Hi,
is it obligatory to use the rt_mutex_inquire in order to get the mutex
state, or could I possibly use the field lockcnt from struct RT_MUTEX
directly? (the test should be, as I believe, atomic - so should I
worry?)

The thing is that I'm using mutices for IPC between an rt-task and a
regular linux process. The rt code is critical, but in the
non-realtime code I can pay the cost of low latency polling to find
out if the realtime code has finished. (Perhaps there is a better way
to do it? The code now looks like this:

RT_MUTEX busy;
RT_COND data_ready;
// both are initialized (elsewhere)

void realtime_thread(void *) {
  rt_mutex_acquire(&busy, 0);
  for(;;) {
    rt_cond_wait(&data_ready, &busy, TM_INFINITE);
    // here it does something critical - it actually communicates
    // with an external device over serial port using the famous rtdm
    // serial driver developed and maintained by Jan Kiszka.
  }
}
 ...
// there is only one thread that communicates with the realtime
// thread above - and this code is invoked within it.
rt_cond_signal(&data_ready);
// now the rt-thread does something. I can estimate the upper time limit
// of the one iteration of that task.
usleep(predicted_time);
if(busy.lockcnt) {
  // timeout - this is possible as it depends on the external devices. Of course
  // sooner or later the mutex will be released by the rt thread.
}

is there any wiser way to communicate these threads?)

