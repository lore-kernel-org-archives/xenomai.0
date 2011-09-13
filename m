From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <13263236d9e.sdiani@domain.hid>
References: <13263236d9e.sdiani@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Sep 2011 16:22:24 +0200
Message-ID: <1315923744.2096.17.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] R: Re: Adeos for PowerPc 2.6.29.4-64 bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: "sdiani@domain.hid" <sdiani@domain.hid>
Cc: adeos-main@gna.org

On Tue, 2011-09-13 at 16:14 +0200, sdiani@domain.hid wrote:
> I mean, the patch applied is for the 32-bit.

No. Adeos -powerpc patches support both 32 and 64bit platforms. Check
the contents.

> The kernel is compiled 64-bit.
> How can I do to have or create the
> "adeos-ipipe-2.6.29.4-powerpc64.patch" ? 
> If is possible.
> 
> Thanks
> 
>         ----Messaggio originale----
>         Da: rpm@xenomai.org
>         Data: 13-set-2011 9.15
>         A: "sdiani@domain.hid"<sdiani@domain.hid>
>         Cc: <adeos-main@gna.org>
>         Ogg: Re: Adeos for PowerPc 2.6.29.4-64 bit
>         
>         On Tue, 2011-09-13 at 00:54 +0200, sdiani@domain.hid wrote:
>         > Hi,
>         > 
>         >   Is it possible to have an adeos 64-bit patch  for the
>         > 2.6.29.4-64-bit kernel, running on a G5 (PowerPc64)?
>         >   if not, how can I built one ?
>         >   The latest that I found is
>         > "adeos-ipipe-2.6.22-rc5-powerpc64-1.4-00.patch".
>         
>         I don't understand what you mean. The thread you are replying
>         to shows
>         that you already found a working ppc64 patch for 2.6.29.4. If
>         it does
>         not eventually, then you will have to fix it. I don't think
>         anyone is
>         maintaining the pipeline for this old release.
>         
>         > 
>         > Thanks 
>         > Sergio
>         >         ----Messaggio originale----
>         >         Da: sdiani@domain.hid
>         >         Data: 10-mag-2011 14.11
>         >         A: <rpm@xenomai.org>
>         >         Cc: <adeos-main@gna.org>
>         >         Ogg: R: [Adeos-main] R: Re: Adeos for PowerPc
>         2.6.29.4-64 bit
>         >         
>         >         It seems working, it worked for 1 hour without
>         freezing
>         >         Now i want to stress the kernel a bit.
>         >         
>         >         Thanks a lot
>         >         
>         >         Sergio
>         >                 ----Messaggio originale----
>         >                 Da: sdiani@domain.hid
>         >                 Data: 9-mag-2011 17.16
>         >                 A: <rpm@xenomai.org>
>         >                 Cc: <adeos-main@gna.org>
>         >                 Ogg: [Adeos-main] R: Re: Adeos for PowerPc
>         2.6.29.4-64
>         >                 bit
>         >                 
>         >                 Tonight I try it and I will tell You
>         >                 
>         >                 Thanks
>         >                 
>         >                 Sergio
>         >                         ----Messaggio originale----
>         >                         Da: rpm@xenomai.org
>         >                         Data: 4-mag-2011 16.44
>         >                         A:
>         "sdiani@domain.hid"<sdiani@domain.hid>
>         >                         Cc: <adeos-main@gna.org>
>         >                         Ogg: Re: [Adeos-main] Adeos for
>         PowerPc
>         >                         2.6.29.4-64 bit
>         >                         
>         >                         On Wed, 2011-05-04 at 14:57 +0200,
>         >                         sdiani@domain.hid wrote:
>         >                         > 
>         >                         > Hi everyone,
>         >                         > i'm trying to compile the 2.6.29.4
>         64-bit
>         >                         Denx kernel for PowerPC
>         >                         > ( PPC 970 , G5 Desktop ).
>         >                         > I have applied the
>         >                         > patch
>         >
>         adeos-ipipe-2.6.29.4-powerpc-DENX-2.7-04.patch
>         >                         and after
>         >                         > reboot i get this error:
>         >                         > 
>         >                         >                         NIP
>         >                         [000001C968] .power4_idle+0x54/0x58 
>         >                         >                         LR =
>         (null)
>         >                         >                             ....
>         >                         >
>         Exceptionn: 901 at
>         >                         power4_idle+0x54/0x58
>         >                         >
>         LR
>         >                         = .cpu_idle +0x11c/0x1d4
>         >                         > 
>         >                         > It regards the idle_power4.S file
>         and the
>         >                         only changes in it, are
>         >                         > about the CONFIG_SOFTDISABLE.
>         >                         > Can Anyone help me to solve it ?
>         >                         
>         >                         The power save code for powermac
>         won't work as
>         >                         is with Adeos. Try
>         >                         booting with powersave=off.
>         >                         
>         >                         > 
>         >                         > Thank you in advance
>         >                         > 
>         >                         > Sergio
>         >                         >
>         >
>         _______________________________________________
>         >                         > Adeos-main mailing list
>         >                         > Adeos-main@domain.hid
>         >                         >
>         https://mail.gna.org/listinfo/adeos-main
>         >                         
>         >                         -- 
>         >                         Philippe.
>         >                         
>         >                         
>         >                         
>         >                 
>         >                 
>         >         
>         >         
>         > 
>         
>         -- 
>         Philippe.
>         
>         
>         
> 

-- 
Philippe.



