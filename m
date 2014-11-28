From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 28 Nov 2014 11:22:01 -0500
Message-ID: <20141128162201.GX24110@csclub.uwaterloo.ca>
References: <54775097.30705@siemens.com> <20141127181823.GK7842@hermes>
 <547772AF.108@siemens.com>
 <20141127191438.GI24110@csclub.uwaterloo.ca>
 <20141127203400.GP7842@hermes> <54778CF6.6000909@siemens.com>
 <20141127231527.GC24076@hermes>
 <20141128160722.GP24110@csclub.uwaterloo.ca>
 <20141128161112.GH8051@hermes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141128161112.GH8051@hermes>
Subject: Re: [Xenomai] [pull] forge: Adjust default registry mount point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Fri, Nov 28, 2014 at 05:11:12PM +0100, Gilles Chanteperdrix wrote:
> I understand the reasoning, but I like /mnt/xenomai
> 
> So, instead of imposing a mount point to everyone, I would suggest
> to keep /mnt/xenomai as the documented default. And add an option to
> the configure script, to allow users which absolutely want to adhere
> to the FHS to choose another mount point.

Well anyone making a package for a distribution would have to change it
after all.

-- 
Len Sorensen

