Message-ID: <4F91921C.3010501@domain.hid>
Date: Fri, 20 Apr 2012 18:43:08 +0200
From: Michael Trimarchi <michael@domain.hid>
MIME-Version: 1.0
References: <4F8FE2A9.8080303@domain.hid> <4F8FEF3C.5010905@domain.hid>
	<4F917BA4.1090804@domain.hid>
	<4F9181A3.9070306@domain.hid>
	<4F918990.7060200@domain.hid>
	<4F918C17.2090200@domain.hid>
In-Reply-To: <4F918C17.2090200@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] IMX25 timer access patch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Adeos <adeos-main@gna.org>, Michael Trimarchi <trimarchi@domain.hid>

On 04/20/2012 06:17 PM, Gilles Chanteperdrix wrote:
> On 04/20/2012 06:06 PM, Michael Trimarchi wrote:
>> During clock test it stuck for a while and then start again 
> 
> Have you read tip #4 in the "Tips and tricks" section of the porting
> I-pipe to ARM linux document?
> 

gettimeoffset?

> http://www.xenomai.org/index.php/I-pipe:ArmPorting#Tips_and_tricks.
> 

btw this is another potential bug... I will send as a separate patch

        if (timer_is_v1()) {
                tsc_info.u.counter_paddr = phys + MX1_2_TCN;
-               tsc_info.counter_vaddr =(unsigned long)(phys + MX1_2_TCN);
+               tsc_info.counter_vaddr = (unsigned long)(timer_base + MX1_2_TCN)
        } else {
                tsc_info.u.counter_paddr = phys + V2_TCN;
                tsc_info.counter_vaddr = (unsigned long)(timer_base + V2_TCN);

Michael

