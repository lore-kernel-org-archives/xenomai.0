Message-ID: <5488AF3A.8020504@xenomai.org>
Date: Wed, 10 Dec 2014 21:38:18 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20141210183747.GA24110@csclub.uwaterloo.ca>
 <20141210184232.GP1524@hermes.click-hack.org>
 <20141210190240.GB24110@csclub.uwaterloo.ca>
 <20141210190509.GR1524@hermes.click-hack.org>
 <20141210190939.GD24110@csclub.uwaterloo.ca>
 <20141210191350.GT1524@hermes.click-hack.org>
 <20141210191924.GF24110@csclub.uwaterloo.ca> <5488A2BD.3080800@xenomai.org>
 <20141210194405.GH24110@csclub.uwaterloo.ca> <5488A985.2070006@xenomai.org>
 <20141210201140.GL24110@csclub.uwaterloo.ca>
In-Reply-To: <20141210201140.GL24110@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] __ipipe_root_status exported GPL only but used to be
 not GPL only and is breaking other code
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

On 12/10/2014 09:11 PM, Lennart Sorensen wrote:
> On Wed, Dec 10, 2014 at 09:13:57PM +0100, Philippe Gerum wrote:
>> The point is about being able to discuss issues without starting useless
>> rants or flame wars.
> 
> I was not trying to.  I think I was getting frustrated chasing around
> git trees wondering why I could not figure out where the change came from.
> 
>> The I-pipe interface was moved to GPL_ONLY to clearly state that such
>> code intimately depends on the kernel innards, has to know about them to
>> function, and therefore any client code has to be GPL-compatible to
>> comply with the kernel license.
> 
> Well I think most of the interfaces were already GPL only even in 2.6.36
> from what I can tell, so nothing new there.
> 

GPL_ONLY is a clear statement that if somebody converts this to plain
EXPORT_SYMBOL() in the code in order to link whatever non-GPL module, he
is definitely and willingly violating the kernel license. This does make
a difference.

-- 
Philippe.

