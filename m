Message-ID: <424AEC00.9000502@domain.hid>
Date: Wed, 30 Mar 2005 21:12:16 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] RE: RTAI/fusion 0.7
References: <1CFEB358338412458B21FAA0D78FE86D505935@domain.hid>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D505935@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: rtai@domain.hid, rtai-dev@domain.hid, adeos-main@gna.org

Fillod Stephane kirjoitti:
> Hi Philippe,
> 
> Kudos for the RTAI/fusion 0.7 release!
> You (the team) are doing an astounding work.
> 
> [snip]
> 
>>o The Adeos support used in fusion has been upgraded to final releases,
> 
> 
>>namely r9/x86 and r6/ppc. Upgrading is strongly recommended, especially
> 
> 
>>if CONFIG_PREEMPT is enabled in your kernel config, which is likely
> 
> with 
> 
>>fusion. Also note that Adeos PPC is now rebased on mainline (2.6.10 
>>actually).
> 
> 
> Please find attached a patch of Adeos r6/ppc against 2.6.11.
> I hope I've got it right. Please let me know if it would need 
> the spinlock fix in i386-r10c1.

The patch seemed ok, but the kernel isn't. There's a bug that causes the 
plain kernel schedule while in atomic region (see
http://ozlabs.org/pipermail/linuxppc-dev/2005-March/018497.html
)
I don't know if this affects embedded archs, but anything using entry.S 
seems to be affected. I wouldn't use 2.6.11 on ppc32.

-- Heikki Lindholm



