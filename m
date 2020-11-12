Subject: Re: [xenomai-images] Scheduled builds
References: <92104706-1f36-9955-5fea-01641e2820a1@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <88bf6ff1-ed1d-363d-90b2-1360c4476f2e@siemens.com>
Date: Thu, 12 Nov 2020 08:44:58 +0100
MIME-Version: 1.0
In-Reply-To: <92104706-1f36-9955-5fea-01641e2820a1@siemens.com>
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
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11.11.20 10:11, Gylstorff Quirin wrote:
> Hi ,
> 
> 
> I am looking into build scheduling for xenomai-images.
> 
> Are there preferences for which builds should run on each commit, e.g.
> Qemu based build and tests for each commit and all builds/test on a
> nightly base.
> 
> It is more or less adding a condition to each build and we can change it
> later.
> 

Well, nightly builds are specifically useful for checking against
dependencies that are not under our control. Otherwise, the preferred
solution, on the long ran at least, would be triggers and dedicated runs
on pushes to our trees:

 - xenomai-images changes -> full run with both "stable" (default)
   versions and head revisions
 - xenomai changes to next/master/stable -> execution of relevant jobs
   (e.g. excluding stable/* targeting jobs if next is modified)
 - ipipe-<arch> changes -> execution of affected boards/qemu targets

If those triggered builds are hard or impossible to model, nightly
builds could be workaround.

Jan
-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


