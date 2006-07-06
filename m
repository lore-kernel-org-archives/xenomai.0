Message-ID: <44AC8482.6000902@domain.hid>
Date: Thu, 06 Jul 2006 00:33:22 -0300
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] FPU not available in user-space programs
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

I was looking at /proc/xenomai/faults and noticed that the only errors 
were on TRAP 7 (FPU not available).

Each time I run the user-space program using the native skin, I 
increment the fault by one. I don't understand why this happens. From 
documentation, FPU should be enabled automatically for user-space programs.

Any ideas why I'm getting this error and what does it mean? Should I do 
some float-point operation before creating my real-time tasks?

Thanks in advance,

Rodrigo.


		
_______________________________________________________ 
Novidade no Yahoo! Mail: receba alertas de novas mensagens no seu celular. Registre seu aparelho agora! 
http://br.mobile.yahoo.com/mailalertas/ 
 



