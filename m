Resent-Message-ID: <20141017190743.GO30661@sisyphus.hd.free.fr>
Resent-To: xenomai@xenomai.org
Date: Fri, 17 Oct 2014 21:02:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141017190227.GM30661@sisyphus.hd.free.fr>
References: <A83EBA0226A300439B44DB00FD90D6560F2C18@NDMSMBX402.ndc.nasa.gov>
 <20141017180743.GK30661@sisyphus.hd.free.fr>
 <A83EBA0226A300439B44DB00FD90D6560F2CD2@NDMSMBX402.ndc.nasa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A83EBA0226A300439B44DB00FD90D6560F2CD2@NDMSMBX402.ndc.nasa.gov>
Subject: Re: [Xenomai] Menuconfig
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Mallik, Udayan (GSFC-5640)" <udayan.mallik-1@nasa.gov>

On Fri, Oct 17, 2014 at 06:32:00PM +0000, Mallik, Udayan (GSFC-5640) wrote:
> The documentation is misleading - the instructions do not match the parameters shown on screen.

I find this documentation clear:
http://xenomai.org/2014/06/configuring-for-x86-based-dual-kernels/

Yes it lists options by their name in the .config rather than their
position in the menus, because:
- the positions in the menus change over time, we have been
maintaining this project for 10 years, the config options name
change rarely;
- people who are accustomed to building Linux (the
majority of Xenomai users) know what an option name beginning with
CONFIG_ means and how to find it.

If you do not know how to configure a kernel and what kernel options
are, I would suggest to go to kernelnewbies.org. Our resources to
answer newcomers are not infinite, so, we fix limits to what we are
ready to teach them. Teaching you how to configure and build a
kernel would be a waste of our time, especially since this is well
documented elsewhere.

> 
> I am indeed baffled by your response. You documentation is not
> understandable - especially to newcomers and you respond by asking
> people to read the same documentation again.

If there is something you do not understand about the documentation,
you should point clearly what instead of making vague accusations
and asking us to repeat what the documentation says. At least we
would know you have read the documentation and not simply skimmed
rapidly over it, or read some website dispensing some second hand
information about Xenomai. That would give us the impression that we
are moving forward, instead of going in circles by writing
documentation, then repeating it to newcomer to lazy to read it.

-- 
					    Gilles.

