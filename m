Date: Sun, 15 Apr 2018 09:09:11 +0200 (CEST)
From: g.strobbe@telenet.be
Message-ID: <1618299311.310098094.1523776151729.JavaMail.zimbra@telenet.be>
In-Reply-To: <CAHV4+d4OK6Rda8xd_HCVVW=u3-Xmv5Bjm-A7ZJg=wRFW-i=aGQ@mail.gmail.com>
References: <CAHV4+d4OK6Rda8xd_HCVVW=u3-Xmv5Bjm-A7ZJg=wRFW-i=aGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Configuring for x86-based dual kernels
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Saisravani Tummalapudi <tummalapudisaisravani@gmail.com>
Cc: xenomai <xenomai@xenomai.org>


----- On Apr 14, 2018, at 6:24 PM, Saisravani Tummalapudi tummalapudisaisravani@gmail.com wrote:

Hello
How to disable the options given in the below link provided.Please help us
to solve this problem

https://xenomai.org//2014/06/configuring-for-x86-based-dual-kernels/
_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai

Hello,

That is part of building the kernel.

On https://xenomai.org/installing-xenomai-3-x/#Cobalt_kernel_parameters
under "Building a Cobalt/x86 kernel (32/64bit)" for example
after you type make menuconfig
you get access to all those kernel parameters.

If you like too see the bigger overview: 

https://debian-handbook.info/browse/stable/sect.kernel-compilation.html
under 8.10.3. Configuring the Kernel

or

https://kernelnewbies.org/FAQ/KernelCompilation

Best regards,

Gino


