Message-ID: <49884633.6050403@domain.hid>
Date: Tue, 03 Feb 2009 14:27:15 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <BAY101-W54D5E94646F7B999F81AF8EAC50@domain.hid>
In-Reply-To: <BAY101-W54D5E94646F7B999F81AF8EAC50@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Compiler Options
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
To: Stephen Davies <steve_davies61@domain.hid>
Cc: xenomai@xenomai.org

Stephen Davies wrote:
> Hi all,
>  
> I start by apologising for asking what I imagine is a very basic
> question but it's been driving me nuts all day!  I am currently trying
> to build and compile one of the sample programs - msg_queue.c.  I'm
> using the Code::Blocks IDE with GCC underneath it to compile the
> program.  I have linked in the include directory /usr/xenomai/include
> but when I compile and link my code I get a load of 'undefined
> reference' errors relating to all of the xenomai functions.  On my old
> RTAI setup I have never had to link explicitly to any libs only include
> header files - what am I doing wrong with xenomai? 
>  

Try /usr/xenomai/bin/xeno-config { --xeno-cflags, --xeno-ldflags, etc. }

> My setup is 2.6.27 kernel, Xenomai latest stable, Ubuntu 8.10
>  
> Apologies again for what I imagine is a very simple question, but it's
> driving me nuts!
>  
> Thanks for your help,
>  
> Steve
> 
> ------------------------------------------------------------------------
> Share your photos with Windows Live Photos - Free Try it Now!
> <http://www.microsoft.com/uk/windows/windowslive/products/messenger.aspx>
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

