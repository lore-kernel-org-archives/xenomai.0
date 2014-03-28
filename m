Message-ID: <5335A94C.8040203@xenomai.org>
Date: Fri, 28 Mar 2014 17:54:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1396022634.2464.YahooMailNeo@web163904.mail.gq1.yahoo.com>
 <5335A11C.4080105@xenomai.org>
 <1396025238.91408.YahooMailNeo@web163901.mail.gq1.yahoo.com>
In-Reply-To: <1396025238.91408.YahooMailNeo@web163901.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] usage with 3.10.18 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huub Van Niekerk <huubvanniekerk@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/28/2014 05:47 PM, Huub Van Niekerk wrote:
> On Friday, March 28, 2014 5:20 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> On 03/28/2014 05:03 PM, Huub Van Niekerk wrote:
>
>  > Hi,
>  >
>  > Knowing that xenomai is being tested on armhf before release, were
> there any problems using linux system commands on this platform with the
> 3.10.18 kernel ?
>
>
>  >No version of xenomai has been released since the 3.10 patch.
>
> Do you mean that the xenomai patch for 3.10.18 that I used is not
> released yet ?

The last release of Xenomai is 2.6.3, and it was released without the 
3.10.18 patch. Though it has been tested with it, and no particular 
issue were observed. armhf is not a platform by the way, it is just a 
name for the way the toolchain is compiled (ARM architecture with 
support for VFP floating point instructions).

-- 
					    Gilles.

