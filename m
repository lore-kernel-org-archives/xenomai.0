Message-ID: <4D3B2C93.70005@domain.hid>
Date: Sat, 22 Jan 2011 20:14:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <22767829.221295629285203.JavaMail.SYSTEM@PC-MRINALDI>
In-Reply-To: <22767829.221295629285203.JavaMail.SYSTEM@PC-MRINALDI>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with rt_task_create and rt_task_join
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michel Rinaldi <automation.03@domain.hid>
Cc: xenomai@xenomai.org

Michel Rinaldi wrote:
> Hi to all,
> 
> I'm running an application on a Linux system with kernel 2.6.35.7
> patched with Xenomai 2.5.5.2, Adeos ipipe patch 2.7-04. My
> application uses native skin and creates some realtime tasks, each
> with rt_task_shadow(), each other with rt_task_create(). When I call
> for first time rt_task_create(), this function is very slow (700-800
> ms)

A reason for the service being so slow the first time it is called may
be the on-demand libraries loading. But for this to take a long time,
the native skin library would have to be stored on a really slow storage
device, or compressed and the processor you are using being a really
slow one. Anyway, you do not tell us on what architecture you get this
issue? What processor are you using? Where is the library stored?

-- 
                                                                Gilles.

