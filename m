From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 9 Sep 2015 10:11:15 -0400
Message-ID: <20150909141115.GX15616@csclub.uwaterloo.ca>
References: <55EFD7C1.50606@free.fr>
 <20150909072117.GA20075@hermes.click-hack.org> <55EFE37F.1@free.fr>
 <20150909074838.GA21017@hermes.click-hack.org>
 <55EFF3EE.9030707@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55EFF3EE.9030707@free.fr>
Subject: Re: [Xenomai] i210 porting
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?U3TDqXBoYW5l?= ANCELOT <sancelot@free.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Sep 09, 2015 at 10:55:10AM +0200, Stéphane ANCELOT wrote:
> I agree, but unfortunately, at the moment I have to stick on 3.16 since my
> debian jessie is based on it....I have to check if they have made
> 3.18 kernel available for this release.
> I have not checked if there were lot of changes between 3.16 and 3.18 igb
> driver at the moment.
> I will have a look at it.
> I will try my port , and if it does not succeed, I will ask for some kind of
> help.Thanks however.

Jessie will almost certainly stick with 3.16, which is being used by
debian and ubuntu and is being maintained by the canonical kernel team
(hence the ckt in the version number).

You can maybe find a backport of a testing kernel for jessie at some
point, but it is likely to be 4.x, not 3.18 and hence probably not
supported by ipipe yet.

-- 
Len Sorensen

