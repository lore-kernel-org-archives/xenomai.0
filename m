Date: Fri, 22 May 2015 18:34:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150522163448.GB1952@hermes.click-hack.org>
References: <20150521221811.1cc69dcd@crunchbang>
 <20150521212432.GQ10686@hermes.click-hack.org>
 <20150522003719.6e865e50@crunchbang>
 <CALRX=SEFcMKcw-SuZTABQ0HcTFo6rym4-BjvjDWhtes-UY8+gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALRX=SEFcMKcw-SuZTABQ0HcTFo6rym4-BjvjDWhtes-UY8+gw@mail.gmail.com>
Subject: Re: [Xenomai] Raspberry Pi + Xenomai doesn't compile
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giovanni Balestrieri <balestrieri.gepp@gmail.com>
Cc: xenomai@xenomai.org

On Fri, May 22, 2015 at 05:37:35PM +0200, Giovanni Balestrieri wrote:
> Hi Marc,
> 
> I had the same problem a few months ago. I've first built a minimal system
> with Buildroot and then applied the Adeos and Xenomai 2.6.3 patches to the
> 3.8.13 kernel.

Bad advice. Please use the latest stable version 2.6.4 and not
2.6.3. The two versions are ABI compatible and 2.6.4 contains fixes
for 2.6.3 bugs.

-- 
					    Gilles.

