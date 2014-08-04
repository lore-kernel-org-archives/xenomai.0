Message-ID: <53DFB9A7.1070406@xenomai.org>
Date: Mon, 04 Aug 2014 18:49:43 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <04b7f4b48b4341899e95f7b3a0d8c52e@CVEX13.valentin-carl.de>
In-Reply-To: <04b7f4b48b4341899e95f7b3a0d8c52e@CVEX13.valentin-carl.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel configuration CONFIG_SYSFS_DEPRECATED
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Reitinger, Peter" <preitinger@carl-valentin.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/04/2014 03:52 PM, Reitinger, Peter wrote:
> Dear Xenomai people,
> 
> is the configuration option CONFIG_SYSFS_DEPRECATED necessary for Xenomai working correctly?
> 

No (unless there is an indirect dependency I'm not aware of), Xenomai
does not export any data through sysfs. A truckload of arm board kernels
need this though.

> Kind regards
> Peter Reitinger
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 


-- 
Philippe.

