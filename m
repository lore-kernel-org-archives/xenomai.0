Message-ID: <5279491A.4040106@xenomai.org>
Date: Tue, 05 Nov 2013 20:38:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52790094.2040608@siemens.com>
In-Reply-To: <52790094.2040608@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-forge: merging debian/* from xenomai-2?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gernot Hillier <gernot.hillier@siemens.com>
Cc: xenomai@xenomai.org

On 11/05/2013 03:28 PM, Gernot Hillier wrote:
> Hi there!
> 
> Debian build for Xenomai-forge currently seems unmaintained, right?
> 
> For me it looks like someone should merge debian/*-touching commits from 
> 2012-08 onwards (2a229690d) into -forge, right?
> 
> Is anyone probably about to fix this? :-)
> 
> Shall I try to prepare an according series? Please note, though, that 
> I'm not really a Debian kernel packaging expert, so if someone feels 
> more responsible...
> 

Hi Gernot,

I did not commit the Debian changes to -forge on purpose:
- we are not in a hurry to change this on forge as we are not yet at the
point of making a release;
- maybe we will have some feedback from Debian users of 2.x which will
trigger changes in the way the packages are built.

However if you need the Debian packaging, please feel free to submit the
patches.

Regards.

-- 
                                                                Gilles.

