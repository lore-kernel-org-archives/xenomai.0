Date: Tue, 25 Sep 2007 08:09:40 -0700 (PDT)
From: poornima r <rpoornar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <330902.482.qm@domain.hid>
Subject: [Adeos-main] EBUSY error with rt_intr_create API for timer interrupt
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hello,

I am trying to register an handler for the timer
interrupt with the following call in my init_module()
(kernel space) for xenomai domain.

err = 
rt_intr_create(&intr_desc,"ir-xenomai",TIMER_INTERRUPT,
&ir_handler,NULL, I_SHARED);
 
When I try inseting my module, I get EBUSY error.

Is there any problem with the interrupt object
creation mode (I_SHARED)?
Why is this error when interrupts can be shared
between 
Xenomai and Linux?


Poornima










 


       
____________________________________________________________________________________
Building a website is a piece of cake. Yahoo! Small Business gives you all the tools to get online.
http://smallbusiness.yahoo.com/webhosting 

