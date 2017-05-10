References: <20170510170616.2f6d7a1a@md1em3qc>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ea3c7c5d-37a6-ba72-e981-a6ca05f5d332@xenomai.org>
Date: Wed, 10 May 2017 17:36:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170510170616.2f6d7a1a@md1em3qc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] copperplate tunables with dso
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/10/2017 05:06 PM, Henning Schild wrote:
> Hi,
> 
> today i have to a question from an application developers point of
> view. How do i override the default value of a tunable when libcobalt
> is linked with dlopen()?
> This article https://xenomai.org/2015/05/application-setup-and-init/
> describes the tunables but not the dso-case.
> 
> Is there a way to override the default values when using dlopen()?
> Maybe delaying the call to the constructors, or passing some arguments
> to them?
> 

Since 3.0.4, DSOs can have their own bootstrap module [1]. So I would
define some setup descriptor with the proper ->tune() handler in the DSO
code the same way one would do in the main executable, then use
xeno-config's --auto-init-solib flags for linking the resulting DSO,
which would glue the bootstrap code in charge of running the setup calls.

[1]
http://git.xenomai.org/xenomai-3.git/commit/?id=d6d8047ecd093bd827026678b3c7619b08dd7dd2

-- 
Philippe.

