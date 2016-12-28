References: <8c50175f71b97232ddbe.1481551766@devws148.be.alcatel-lucent.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <fed363ba-6580-1b51-7f6f-bd2e4a6708e3@xenomai.org>
Date: Wed, 28 Dec 2016 16:11:27 +0100
MIME-Version: 1.0
In-Reply-To: <8c50175f71b97232ddbe.1481551766@devws148.be.alcatel-lucent.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v2] psos: add tunables to configure region 0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>, xenomai@xenomai.org

On 12/12/2016 03:09 PM, Ronny Meeus wrote:
> +	case region0_size_opt:
> +		psos_region0_size = (u_long)atol(optarg);
> +		break;
> +	case region0_unitsize_opt:
> +		psos_region0_unitsize = (u_long)atol(optarg);
> +		break;

You may want to sanitize the input values.

> +	if (psos_region0_size) {
> +		u_long rsize;
> +		ret = rn_create("_RN0", xnmalloc(psos_region0_size), psos_region0_size,

If the value passed to --psos-rn0-size is larger than the memory
available from the main heap, rn_create() will crash on a NULL return
from xnmalloc().

-- 
Philippe.

