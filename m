Message-ID: <434E19AD.4030500@domain.hid>
Date: Thu, 13 Oct 2005 10:24:13 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Future of fusion
References: <000d01c5cfcb$8b5dfaf0$0600a8c0@domain.hid>
In-Reply-To: <000d01c5cfcb$8b5dfaf0$0600a8c0@domain.hid>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Marco Cavallini <rtai@domain.hid>
Cc: xenomai@xenomai.org

Marco Cavallini wrote:
> Hello,
> I'd like to know (if is possible) the future plans and task schedule of 
> fusion into xenomai project.
> TIA

There are things already going on "under the surface" right now, and others that 
would depend on everyone's input in order to start them or not. The roadmap will 
clearly depend on the combination of both aspects. I will give some details 
shortly about the current or next-to-be-started efforts, but the feedback part 
is important too, so here is the call for discussion once posted to this list:

--

I propose that we start discussing along the following lines, going into deeper 
detail as needed, but in any case, please remember that we don't have infinite 
resources to do everything at once, and that we need to keep an organisation 
that fits our abilities to manage it, so let's keep it modest and efficient. If 
I missed some important issues, please jump in. After that initial work, we 
should be able to define a sensible roadmap.

- Regular automated benchmarking: What is Xenomai currently capable of, how 
stable is it, do we progress or regress over time and releases, arch by arch?

- Documentation effort, dissemination: I'm a potential new user, do I have some 
unambiguous source of information available to get my feet wet with Xenomai?

- Architecture ports: There is life beyond x86.

- Kernel ports: Is there still room for a 2.4 port?

- Configuration, building and packaging issues: Could we make this easier?

- Linux integration issues: Tools we should interface with, features we should 
make more seamless.

- Scalability: Is Xenomai scalable enough? What's missing?

- Drivers: Now that we have a deeply integrated port of RTDM, what's next? Field 
busses and other industrial gizmos anyone?

- Current interfaces: Are we happy with them?

- New skins: Any new colors for the "chameleon"?

-- 

Philippe.

