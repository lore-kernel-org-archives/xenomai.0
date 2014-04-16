Message-Id: <B727F431-67A4-4990-A4B2-8B0205C3EFDC@gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
In-Reply-To: <53C1B9A4-9035-4E75-8553-553E8F31EFCC@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date: Wed, 16 Apr 2014 11:18:42 +0100
References: <53C1B9A4-9035-4E75-8553-553E8F31EFCC@gmail.com>
Subject: Re: [Xenomai] Linux 3.14 with Xenomai 2.6.3 on a Pandaboard
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

A couple of corrections:

> > git remote add ipipe git://http://git.xenomai.org/ipipe.git
> > git pull ipipe raw raw/ipipe-3.14.0 # requires a commit to the  
> local git tree

git remote add ipipe git://git.xenomai.org/ipipe.git
git pull ipipe raw/ipipe-3.14.0 # requires a commit to the local git  
tree


> 4) Install the kernel assuming u have a working debian system  
> (otherwise use ./build_kernel.sh and follow [1]):
> > cd ${BASEDIR}/armv7-multiplatform

cd ${BASEDIR}/armv7-multiplatform/deploy

A.


