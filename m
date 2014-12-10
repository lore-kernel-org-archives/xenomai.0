From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 10 Dec 2014 14:55:55 -0500
Message-ID: <20141210195555.GJ24110@csclub.uwaterloo.ca>
References: <20141210183747.GA24110@csclub.uwaterloo.ca>
 <20141210184232.GP1524@hermes.click-hack.org>
 <20141210190240.GB24110@csclub.uwaterloo.ca>
 <20141210190509.GR1524@hermes.click-hack.org>
 <20141210190939.GD24110@csclub.uwaterloo.ca>
 <20141210191350.GT1524@hermes.click-hack.org>
 <20141210191924.GF24110@csclub.uwaterloo.ca>
 <20141210192419.GU1524@hermes.click-hack.org>
 <20141210193946.GG24110@csclub.uwaterloo.ca>
 <20141210194723.GW1524@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141210194723.GW1524@hermes.click-hack.org>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Dec 10, 2014 at 08:47:23PM +0100, Gilles Chanteperdrix wrote:
> If you checkout
> https://git.xenomai.org/ipipe.git/log/?h=raw-ipipe-3.16
> You have all the changes that were made since we started working
> with a unique tree. As for the change you are referring to, this is
> not a change, as explained in the other answer I just sent.

So I guess the part I would love to know is where did te code for this
commit come from:

commit a6118a10918dea6cd9206d2a5127fa1717180fc3
Author: Jan Kiszka <jan.kiszka@siemens.com>
Date:   Tue Feb 5 21:28:38 2013 +0100

    ipipe: Import generic and x86 bits based on 3.5.7-x86-3

After all that is the first place I see where the symbol in question
has GPL only.

-- 
Len Sorensen

