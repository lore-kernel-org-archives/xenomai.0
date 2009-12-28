Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B3918B1.6050502@domain.hid>
Date: Mon, 28 Dec 2009 21:44:33 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
References: <729c4a400912260654vf4f99d1ta6105bdace1b4098@domain.hid>
In-Reply-To: <729c4a400912260654vf4f99d1ta6105bdace1b4098@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Sensoray 526 analogy driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Simon Boulay <simon.boulay@domain.hid>, "Alessio Margan @ IIT" <alessio.margan@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Hi Simon,

Simon Boulay wrote:
 > Hi,
 >
 > Here is a patch which adds the support of the Sensoray Model 526 board
 > to analogy.

Great ! I had a look at the code, that is fine for me. I just have few
remarks:
- some "printk" were left commented in the original comedi driver, you
correctly translated them into a4l_info; however, could you use a4l_dbg
instead and remove the comments ?
- the sources of the original driver contain many areas of commented
code and "#if 0 #else #endif" directives. In order to keep coherency
with the original driver, I think the import of the driver should be
done as it is; nonetheless, the second step would be to clean it inside
the git repository.

I think it is wise to wait for the release of 2.5 before integrating it. 
It will be made available in Xenomai 2.5.1.

 > The driver compiles against head but have not been tested on real 
hardware yet.
Alessio was interested by this driver; Alessio, the driver is yours as
soon as it is available in my git repository.

 > It has been ported from comedi (staging version) and should work as 
in comedi:
 > - Encoder works
 > - Analog input works
 > - Analog output works
 > - PWM output works
 > - Commands are not supported yet.
 >
 > Regards,
Many thanks for your work !

 > Simon.
 >
Alexis.



