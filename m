Message-ID: <BLU437-SMTP996B2B5AFA76BF27714924F0100@phx.gbl>
References: <BLU436-SMTP777DC6298F62C65606DFEF0100@phx.gbl>
 <20151114053841.GF1820@hermes.click-hack.org>
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Date: Fri, 13 Nov 2015 22:06:56 -0800
MIME-Version: 1.0
In-Reply-To: <20151114053841.GF1820@hermes.click-hack.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] IPIPE patch for BCM2709/RPI2.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 15-11-13 09:38 PM, Gilles Chanteperdrix wrote:
> On Fri, Nov 13, 2015 at 09:31:23PM -0800, Mathieu Rondonneau wrote:
>> From 6f985ebdd2c99257fb3873b9cb83ba6572dff60a Mon Sep 17 00:00:00 2001
>> From: Mathieu Rondonneau <mathieu.rondonneau@gmail.com>
>> Date: Fri, 13 Nov 2015 20:59:49 -0800
>> Subject: [PATCH] IPIPE patch for BCM2709.
>>
>>  - kernel: https://github.com/raspberrypi/linux (rpi-3.18.y)
>>    - 1bb18c8f721ef674a447f3622273f2e2de7a205c
> 
> As explained here:
> http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/#Working_with_vendor_forks
> 
> If the patch is not for mainline Linux it should be sent as a couple
> of pre and post patches.
> 
there is no pre.patch required here, the ipipe patch from xenomai repo
apply with no conflict so I am not sure what to put in pre.patch.


