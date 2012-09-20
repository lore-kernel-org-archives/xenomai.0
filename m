Message-ID: <505AF641.6030604@siemens.com>
Date: Thu, 20 Sep 2012 12:56:01 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <505AF205.6010206@siemens.com> <505AF49D.6020905@xenomai.org>
In-Reply-To: <505AF49D.6020905@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] Revert "ipipe: ipipe_request_irq(),
 ipipe_free_irq() are root-only services"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Mauerer, Wolfgang" <wolfgang.mauerer@siemens.com>, Xenomai <xenomai@xenomai.org>

On 2012-09-20 12:49, Philippe Gerum wrote:
> On 09/20/2012 12:37 PM, Jan Kiszka wrote:
>> This reverts commit 073ff1e8045d0311b8cf390687c0ba3619681672.
>>
>> Both service are NOT just root-only services. E.g., rtdm_irq_request
>> requires by specification support also over non-Linux contexts.
> 
> Nack. We can't run the enable code for MSIs over non-root, and
> that code typically follows the irq request. Besides, we want to mask
> the source upon irq free to handle the SMP case properly, which we could
> not do from non-root with MSIs.
> 
> So either we have both request+enable and free usable over non-root, or
> there is no point.

OK, I get the point with legacy MSI. Then we have two other bugs to solve:
 - in I-pipe as it holds a hardened spin lock across enable/disable (of
   MSIs)
 - in Xenomai 2.6 (at least, didn't check forge) as it calls with a
   hardened spin lock held into ipipe_virtualize_irq

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

