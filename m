Message-ID: <5565AF40.3070502@xenomai.org>
Date: Wed, 27 May 2015 13:49:20 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <d0dc8c289d0b45fafbb6b39b839b468bd53f256f.1430395105.git.henning.schild@siemens.com>	<20150527111126.2f03fa66@md1em3qc>	<55658C9D.8020406@xenomai.org>
 <20150527130931.27f37fcb@md1em3qc>
In-Reply-To: <20150527130931.27f37fcb@md1em3qc>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] debian: remove xeno-config from
 libxenomai-dev package
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: xenomai@xenomai.org

On 05/27/2015 01:09 PM, Henning Schild wrote:
> On Wed, 27 May 2015 11:21:33 +0200
> Philippe Gerum <rpm@xenomai.org> wrote:
>  
>> You mean this?
>>
>> http://git.xenomai.org/xenomai-3.git/commit/?id=571ec165ad6a22d3f93f6197b64eb8edba8fbee4
> 
> Ahh. Yes i meant this. The actual conclusion of the discussion to this
> patch was to revert the change that introduced the problem and not
> apply my patch. But for me either way is fine.
> 

Actually, the right approach is to move xeno-config to the base package,
since it now delivers information about the runtime system as well.

> I also referred to another change i suggested and am still waiting for
> feedback:
> https://xenomai.org/pipermail/xenomai/2015-April/034105.html
> 

Looks ok. I'll pick that one unless Gilles pulls the break for any
debian-specific issue.

-- 
Philippe.

