Message-ID: <540A0A92.2000405@xenomai.org>
Date: Fri, 05 Sep 2014 21:10:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140905184346.GN17690@csclub.uwaterloo.ca>
In-Reply-To: <20140905184346.GN17690@csclub.uwaterloo.ca>
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
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, xenomai@xenomai.org

On 09/05/2014 08:43 PM, Lennart Sorensen wrote:
> I tried using --enable-debug with configure and it claims it did it,
> but according to gdb, the resulting libraries do not have debug symbols.
> 
> I see -g added to the gcc line all over the place, except when libtool
> does the final linking where for some reason it has disappeared (while
> all other options appear to have made it through).
> 
> This is on powerpc.
> 
> Any ideas?
> 
run the "file" utility on the library to see whether or not it has
debugging information.

-- 
                                                                Gilles.

