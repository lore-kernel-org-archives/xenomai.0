Subject: Re: [PATCH 2/2] cobalt: switch hand over status to -ENODEV for
 non-RTDM fd
References: <20190620172934.31393-1-rpm@xenomai.org>
 <20190620172934.31393-3-rpm@xenomai.org>
 <VI1PR05MB5917F833764544DF7F3E666FF6A20@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d9753848-2a95-a1a4-fbd9-c5aa2989fe67@xenomai.org>
Date: Thu, 29 Aug 2019 16:45:24 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB5917F833764544DF7F3E666FF6A20@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 8/29/19 4:12 PM, Lange Norbert wrote:
> 
> I ran into a rather big issue with linux filehandles
> I use Xenomai master on ipipe-core-4.19.60-x86-5 with those patches,
> (can't be 100% sure its not some kernel/userspace conflict, but I doubt it)
> 
> What happens is that upon a __cobalt_close with a linux filehande, the
> syscall sc_cobalt_close returns EBADF, but that means the libc close will
> never be tried and filehandles are leaking like mad.
> 

You may need v3:

https://lab.xenomai.org/xenomai-rpm.git/commit/?h=for-upstream/next&id=42b7d3d43d9476a101103ad1a3d52ee6822b52e6

-- 
Philippe.

