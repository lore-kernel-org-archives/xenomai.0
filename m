Message-ID: <5018F130.40301@xenomai.org>
Date: Wed, 01 Aug 2012 11:04:48 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <208C6975C932E94F86239FEA59CCA632068318D3@AUSMXMBX02.mrws.biz>
	<50128EE5.3090904@xenomai.org>
	<208C6975C932E94F86239FEA59CCA63206831B5C@AUSMXMBX02.mrws.biz>
In-Reply-To: <208C6975C932E94F86239FEA59CCA63206831B5C@AUSMXMBX02.mrws.biz>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [PATCH, Xenomai 2.5.6]
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: dietmar.schindler@manroland-web.com
Cc: xenomai@xenomai.org

On 08/01/2012 08:58 AM, dietmar.schindler@manroland-web.com wrote:
>> -----Original Message-----
>> From: Philippe Gerum [mailto:rpm@xenomai.org]
>> Sent: Friday, July 27, 2012 2:52 PM
>> To: Schindler, Dietmar RAEK1 MRA
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai] [PATCH, Xenomai 2.5.6]
>>
>> On 07/27/2012 02:45 PM, dietmar.schindler@manroland-web.com wrote:
>>> These are patches for two files in ksrc/nucleus of Xenomai 2.5.6 to cure
>> an incompatibility with Linux 2.4; if they are bad in form, please let me
>> know.
>>>
>>
>> You should backport this patch from the 2.6 tree instead:
>> e3c13f0685c2edf2a2ce30cd239b3f
>
> I'm sorry, I can't figure out how to locate this patch.

 From this tree:
git://git.xenomai.org/xenomai-2.6.git

  However, I found the attached message where you pointed to another 
patch, just for Xenomai 2.5.6, so I'll use that one, and let's forget my 
surplus duplication of work.
>
> --
> Dietmar
> ________________________________________
> manroland web systems GmbH -- Managing Director: Uwe Lüders
> Registered Office: Augsburg -- Trade Register: AG Augsburg -- HRB-No. 26816 -- VAT: DE281389840
>
> Confidentiality note:
> This eMail and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. If you are not the intended recipient, you are hereby notified that any use or dissemination of this communication is strictly prohibited. If you have received this eMail in error, then please delete this eMail.
>
> - Please consider your environmental responsibility before printing this eMail
> ________________________________________
> -------------- next part --------------
> An embedded message was scrubbed...
> From: <rpm@xenomai.org>
> Subject: Re: [Xenomai-help] Xenomai 2.5.6 with PPC-Kernel 2.4.25
> Date: Sat, 18 Jun 2011 08:50:52 +0000
> Size: 10752
> URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120801/8d87a614/attachment.mht>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.

