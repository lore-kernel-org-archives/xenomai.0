From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Date: Tue, 25 Jul 2006 17:35:35 -0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607251735.35500.lbocseg@domain.hid>
Subject: [Xenomai-help] How can I now when it will be next periodic task
	release point?
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

I want to capture and process images each 300 ms. The processing routines take 
a (fixed, but unknown) time. I'd like to request a new image about 50 ms 
before next release point, like this:

for(;;)
{
	rt_task_wait_period(NULL);
	ProcessImage();
	rt_task_sleep(XXX); // until 50 ms before next release point
	RequestNewImage();
}

I could use rt_task_inquire() if RT_TASK_INFO was documented. From 
source-code:
  RTIME relpoint;             /* !< Periodic release point. */

The question is which release point? Next or the last reached?
Anyway, a new function like rt_task_getnextrelpoint() would be very welcome...

rt_task_sleep(rt_task_getnextrelpoint() - 50*1000*1000);

Thanks in advance,

Rodrigo.


		
_______________________________________________________ 
Novidade no Yahoo! Mail: receba alertas de novas mensagens no seu celular. Registre seu aparelho agora! 
http://br.mobile.yahoo.com/mailalertas/ 
 



