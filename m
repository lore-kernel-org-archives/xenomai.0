Message-ID: <50B74CC4.90902@mediso.hu>
Date: Thu, 29 Nov 2012 12:53:40 +0100
From: Norbert Bukuli <norbert.bukuli@mediso.hu>
MIME-Version: 1.0
References: <50B739B8.9090509@mediso.hu> <50B74521.9010808@grandegger.com>
In-Reply-To: <50B74521.9010808@grandegger.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] MPC5200 MSCAN GPIO routing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: xenomai@xenomai.org

I see.
Sorry for the missed attachment.

Thank you.

On 2012-11-29 12:21, Wolfgang Grandegger wrote:
> On 11/29/2012 11:32 AM, Norbert Bukuli wrote:
>> Hello all,
>>
>> I missed the GPIO routing functionality of MSCAN in MPC5200.
>> Please check the attached patch, whether is it usable.
>
> Unfortunately, the attachment is missing. Anyway, the proper GPIO
> routing should be setup either by the boot loader or by platform code
> (in arch/powerpc/platforms/52xx). That's why we do not have it anymore
> in the driver.
>
> Wolfgang.
>
>

-- 
Best regards,
Norbert Bukuli

