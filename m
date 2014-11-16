Date: Sun, 16 Nov 2014 07:35:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141116063547.GP4656@sisyphus.hd.free.fr>
References: <20141116062956.GO4656@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141116062956.GO4656@sisyphus.hd.free.fr>
Subject: Re: [Xenomai] Pull requests.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On Sun, Nov 16, 2014 at 07:29:56AM +0100, Gilles Chanteperdrix wrote:
> Hi Philippe,
> 
> please pull from ipipe-gch.git the branches:
> for-ipipe-3.10

Correction, the for-ipipe-3.10 branch can not run RTnet, it does not
have the change allowing to use try_module_get/module_put from
primary mode, and it is less easy to do (module_put calls
wake_up_process). 

-- 
					    Gilles.

