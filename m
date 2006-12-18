Message-ID: <45869F7A.7010208@domain.hid>
Date: Mon, 18 Dec 2006 15:02:34 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-help] prepare kernel fails
References: <5D63919D95F87E4D9D34FF7748CE2C2A6F92B2@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A6F92B2@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
>> The missing directory will not harm. Anyhow, if you start 
> 
> It does harm, as the kernel is prepared only partialy and make
> menuconfig crashes.

Ah, OK. A quick hack is to remove "sim" from prepare_kernel.sh, or 
better use -rc3.

>> testing 2.3-rcX now, please use xenomai-2.3-rc3.
>>
> 
> I did not know, that this version exists and (!) I did not know where it
> resides.
> (No hint on www.xenomai.org, but the mailing list showed me the way). 

It has been announced on the Xenomai mailing lists:

https://mail.gna.org/public/xenomai-help/2006-12/msg00106.html

Wolfgang.


