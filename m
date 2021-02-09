Subject: Re: [xenomai-images][PATCH 1/2] linux-xenomai: Fix arm/arm64 latest
 branches, add 5.4 option
References: <ca6c935b-a10c-589c-502d-0b9e439c7089@siemens.com>
 <CALLqZ8RGYh5qevRX3NJ88MRrPcJyDfX0H2bd=d4TLiRBNCZ9hg@mail.gmail.com>
 <4c9069df-2a3f-0a63-9553-f2da4679c8fa@qmul.ac.uk>
 <a181852d-d194-5b87-6559-5358a1accc5a@siemens.com>
 <3a693cb3-2dd3-288a-f717-0c366267db1e@qmul.ac.uk>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <422657c1-9e11-2f6a-20a3-d3634eea77eb@siemens.com>
Date: Tue, 9 Feb 2021 20:23:51 +0100
MIME-Version: 1.0
In-Reply-To: <3a693cb3-2dd3-288a-f717-0c366267db1e@qmul.ac.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, Greg Gallagher <greg@embeddedgreg.com>, Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 09.02.21 18:59, Giulio Moro wrote:
>> What you are missing is also :opt-xenomai-next.yml because 5.4 requires
> 
> Yes! This worked:
> 
>   kas-container build
> kas.yml:board-beagle-bone-black.yml:opt-xenomai-next.yml:opt-linux-latest-5.4.yml
> 
> 
> Then I checked out c6fafd0b83752c529483f7ba3a4277d02ce6aace
> (wip/dovetail) and attempted:
> 
>   kas-container build
> kas.yml:board-beagle-bone-black.yml:opt-xenomai-next.yml:opt-linux-latest-5.10.yml
> 
> 
> however this failed because `dovetail/master` was not available in
> GIT_REPO_armhf. I am submitting a patch separately to fix this.
> 

Should be fine now, we both fixed it.

> I also tried to build with gitlab-runner, but the line provided in the
> README didn't work:
> 
> gitlab-runner exec docker --docker-privileged \
>   --env "HTTP_PROXY=$HTTP_PROXY" --env "HTTPS_PROXY=$HTTPS_PROXY" \
>   --env "NO_PROXY=$NO_PROXY" build:qemu-armhf
> 
> fails with
> 
> FATAL: no job named "build:qemu-armhf"
> 
> Note that I don't have any of those variables set in my env and that I
> am not running behind a proxy, but the failure seems to be unrelated (I
> am no docker expert), so maybe the README needs update on this one, too?

Yeah, our README is totally outdated here. We changed the naming scheme
of jobs since then. Plus I'm not sure how to specify the variations
(kernel version, Xenomai versions) this way. Quirin?

Thanks for reporting in any case.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

