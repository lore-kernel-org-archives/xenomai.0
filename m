Date: Wed, 10 May 2017 17:06:16 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170510170616.2f6d7a1a@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] copperplate tunables with dso
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

today i have to a question from an application developers point of
view. How do i override the default value of a tunable when libcobalt
is linked with dlopen()?
This article https://xenomai.org/2015/05/application-setup-and-init/
describes the tunables but not the dso-case.

Is there a way to override the default values when using dlopen()?
Maybe delaying the call to the constructors, or passing some arguments
to them?

kind regards,
Henning

