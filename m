Message-ID: <4FD869B7.1010204@siemens.com>
Date: Wed, 13 Jun 2012 12:21:43 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <CADULeAbdKdwKp_3kvHkAc9YYKFFUo7mr2qqmLJ5Ok3XeeiTQAQ@mail.gmail.com>
	<CADULeAYv_UfY0PTHX3kA7e7OL7KqKRz=aKGpTUi2SoWwx6qMMg@mail.gmail.com>
	<4FD78C87.5020000@xenomai.org>
	<CADULeAZWWSwv=jnw3ozAn8LRhP6+6fR5UsuPzQED6-S6KGJ53w@mail.gmail.com>
	<4FD853FC.4080009@xenomai.org>
In-Reply-To: <4FD853FC.4080009@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Rtdm driver debugging techniques.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 2012-06-13 10:49, Gilles Chanteperdrix wrote:
> On 06/13/2012 10:32 AM, mohammad khalid shaik wrote:
>> Thanks for your quick reply. I have one more question. whether kgdb setup
>> which is handy to debug the linux kernel can be used to debug xenomai?
>>
> 
>>From recent posts:
> http://www.xenomai.org/pipermail/xenomai/2012-June/000199.html
> 
> It appears the I-pipe patch does not work with kgdb.

For older x86, I've a working branch here:

http://git.kiszka.org/?p=ipipe.git;a=shortlog;h=refs/heads/queues/2.6.35-x86-trace-kgdb

The plan is to get the required bits into some I-pipe core-3.x once time
permits.

However, if you are on x86 and have test platform with VT-d or AMD IOMMU
at hand, running Xenomai as KVM guest and passing the PCI adapter
through will enable faster source-level debugging than kgdb can provide.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

