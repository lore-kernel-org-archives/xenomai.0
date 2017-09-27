Date: Wed, 27 Sep 2017 14:15:31 -0400
Message-ID: <20170927181531.r6ufimuxxwh7lbvc@csclub.uwaterloo.ca>
References: <CAKJ14NdyH7FF+pwj9J-FLSnCWHOqAteKVrrbagA4eqhvETgFoA@mail.gmail.com>
 <dffcf471-c697-b04c-7dc9-84c169b5be62@xenomai.org>
 <CAKJ14NdBR+VMq6ovb06nLi1EU4c2rA6TTo=VtC3Zdz1RWdKqZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKJ14NdBR+VMq6ovb06nLi1EU4c2rA6TTo=VtC3Zdz1RWdKqZQ@mail.gmail.com>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [Xenomai] Unexpected mode switches when reordering C++ lines
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andreas Glatz <andi.glatz@gmail.com>
Cc: xenomai@xenomai.org

On Wed, Sep 27, 2017 at 06:25:18PM +0100, Andreas Glatz wrote:
> As you say Philippe, I had to memcpy() 2xu32 from the (malloc'd)
> memory region into an array u32 tmpVal[2] array, and then use these
> values one-by-one to process them with ntohl(), ...

Certainly using memcpy is the safe way to deal with unaligned data.

Casting a char* to an int* is just not valid and breaks aliasing rules.

> I tried to cast the pDat pointer to u32* initially, but then I still
> got the ldm instructions and hence mode switches as the assembler is
> very good at optimizing.
>
> I have the feeling the same could come up at other places as well as
> we progress with the testing of our application. I guess a 'save'
> solution is to compile the code with -O0 or -O1, because if never seen
> these mode switches using these compiler options. However, an ideal
> solution would be to have something to mark the memory region as
> 'unaligned' so the assembler then only uses ldr instead of
> instructions on it... maybe there is this unicorn running around
> somewhere :)
> 
> Anyways, many thanks for your help.

Is this any help:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53016

A bit of searching is starting to make me think your problem is caused
by using reinterpret_cast rather than a plain static cast.  I think
using that is making the compiler say "Oh this is a proper correct fully
aligned pointer of this type, so I can assume anything I want about it".

-- 
Len Sorensen

