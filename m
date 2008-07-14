Message-ID: <487B671F.4050302@domain.hid>
Date: Mon, 14 Jul 2008 16:47:59 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <6132061f0807140533m14460d32oe4f15e50f80974ce@domain.hid>
In-Reply-To: <6132061f0807140533m14460d32oe4f15e50f80974ce@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pipe.ko
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Breno Carneiro Pinheiro <brenodee@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Breno Carneiro Pinheiro wrote:
> Hi, I got compiled the example pipe.c in your two parts (kernel and user
> space). Trying to load the file pipe.ko I got returned:
> 

The snippet in question is just a skeleton; what actual code are you compiling?

> sh-3.00# insmod pipe.ko
> insmod: error inserting 'pipe.ko': -1 No such device
> 
> Am I missing something? Should I load another module before?
> 

"No such device" == ENODEV. You need to find the reason why init_module()
returns ENODEV. Hint: rt_pipe_create() may return -ENODEV, the native API
documentation says why.

-- 
Philippe.

