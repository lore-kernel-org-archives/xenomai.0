Message-ID: <55658C9D.8020406@xenomai.org>
Date: Wed, 27 May 2015 11:21:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <d0dc8c289d0b45fafbb6b39b839b468bd53f256f.1430395105.git.henning.schild@siemens.com>
 <20150527111126.2f03fa66@md1em3qc>
In-Reply-To: <20150527111126.2f03fa66@md1em3qc>
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
To: Henning Schild <henning.schild@siemens.com>, xenomai@xenomai.org

On 05/27/2015 11:11 AM, Henning Schild wrote:
> Hey Guys,
> 
> we have a continuous integration setup here at Siemens. Next to our own
> repos we also compile and test upstream to detect problems before
> merging.
> I know the changes to the debian directory seem unimportant, but our
> current CI infrastructure is built on that. So please consider applying
> my suggestions. Using the CI we hope to find and fix issues in the
> whole project but for that to work we need a reliable way of deploying
> binaries to our test systems.
> 
> If there is a debian directory in the tree, it should be consistent.
> The other option would be to remove it all together, i personally
> prefer the first option.

You mean this?

http://git.xenomai.org/xenomai-3.git/commit/?id=571ec165ad6a22d3f93f6197b64eb8edba8fbee4

-- 
Philippe.

