Message-ID: <54071A1D.6010101@xenomai.org>
Date: Wed, 03 Sep 2014 15:39:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140828203532.GA17690@csclub.uwaterloo.ca>
 <53FF93A3.8070101@xenomai.org> <20140828220153.GE17690@csclub.uwaterloo.ca>
 <53FFA96E.2090904@xenomai.org> <20140828231625.GF17690@csclub.uwaterloo.ca>
 <20140903125422.GI17690@csclub.uwaterloo.ca>
 <20140903132154.GJ17690@csclub.uwaterloo.ca>
In-Reply-To: <20140903132154.GJ17690@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai/Ipipe on arm with LPAE enabled not booting -
 now with crash message
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On 09/03/2014 03:21 PM, Lennart Sorensen wrote:
> On Wed, Sep 03, 2014 at 08:54:22AM -0400, Lennart Sorensen wrote:
>> OK so far I have:
>>
>> static noinline struct kmem_cache_node *free_debug_processing(
>>         struct kmem_cache *s, struct page *page, void *object,
>>         unsigned long addr, unsigned long *flags)
>> {
>>         struct kmem_cache_node *n = get_node(s, page_to_nid(page));
>>
>> pr_info("n: %p flags: %p\n", n, flags);

The next thing to do is to check the get_node and page_to_nid code to
see how this can result in a NULL pointer. Even before that, is the page
pointer valid?

-- 
                                                                Gilles.

