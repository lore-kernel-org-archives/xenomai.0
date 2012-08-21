Message-ID: <503365D9.3050900@xenomai.org>
Date: Tue, 21 Aug 2012 12:41:29 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtew6wmwf_HydBbSDN9+FatOL9DSsSkR2VTYFmDk9-urTA@mail.gmail.com>
In-Reply-To: <CAKKWdtew6wmwf_HydBbSDN9+FatOL9DSsSkR2VTYFmDk9-urTA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] stall/unstall
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 08/21/2012 12:32 PM, ali hagigat wrote:
> Dose rthal_irq_enable(irq) unstalls the domain stage?

No, these operations cannot be related by definition.

>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.

