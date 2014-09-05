Message-ID: <540A2BB3.7020502@xenomai.org>
Date: Fri, 05 Sep 2014 23:31:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140905191447.GO17690@csclub.uwaterloo.ca>
 <540A19DC.10507@xenomai.org> <540A1B2C.2050309@xenomai.org>
 <540A1DA7.8090906@xenomai.org> <20140905205404.GP17690@csclub.uwaterloo.ca>
 <540A23A6.8040205@xenomai.org> <20140905210335.GQ17690@csclub.uwaterloo.ca>
 <540A2563.1050304@xenomai.org> <20140905211515.GR17690@csclub.uwaterloo.ca>
 <540A286C.2050803@xenomai.org> <20140905213028.GS17690@csclub.uwaterloo.ca>
In-Reply-To: <20140905213028.GS17690@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How to get debug symbols in xenomai libraries
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

On 09/05/2014 11:30 PM, Lennart Sorensen wrote:
> On Fri, Sep 05, 2014 at 11:17:32PM +0200, Gilles Chanteperdrix wrote:
>> You do not need to run "make install"
>> Just run configure --enable-debug
>> Then make
>> Then try gdb on the compiled libxenomai.so.0.0.0
>>
>> There are two layers of Makefileries, thee aim is to find where the
>> problem is coming from, not to use this as a solution.
> 
> Well we can give that a try.
> 
> Of course I hate libtool.  It's stupid .libs thing makes it so annying
> to find the actual library.
> 

It is:
src/skins/common/.libs/libxenomai.so.0.0.0

-- 
                                                                Gilles.

