Date: Tue, 24 Feb 2015 15:17:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150224141709.GB14148@hermes.click-hack.org>
References: <9BA84827B30CBE4996725F98F7DC91234290300D@SMExchange01.siebmeyer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9BA84827B30CBE4996725F98F7DC91234290300D@SMExchange01.siebmeyer.org>
Subject: Re: [Xenomai] rt_heap_bind, Error=-11 -> EWOULDBLOCK why?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?SMOkbmVsLUJhYXMs?= Alexander <alexander.haenel-baas@sieb-meyer.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Feb 24, 2015 at 01:48:24PM +0000, Hänel-Baas, Alexander wrote:
> Aha
> I added
> 
> vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot)
> bevor i called remap_pfn_range

Using H_NONCACHED should do the same thing.

-- 
					    Gilles.

