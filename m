Message-ID: <4436187F.8090601@domain.hid>
Date: Fri, 07 Apr 2006 09:45:03 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [Xenoscope] GDB error
References: <f48df4840604061547i4ed0ed5bp32babb8a79138ccd@domain.hid>
In-Reply-To: <f48df4840604061547i4ed0ed5bp32babb8a79138ccd@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Bruno Rouchouse <brouchouse@domain.hid>
Cc: xenomai@xenomai.org, xenomai@xenomai.org

Bruno Rouchouse wrote:
> Hi,
> 
> someone using xenoscope for running simulation ?
> 
> I'm getting a "GDB error: No symbol "mvm_bp" in current context." while 
> launching my simulation under the xenoscope.
> 
> Other information: I'm using GNU gdb 6.3-debian and simulation process 
> works fine directly under gdb (can break in code, run simulation etc.)
>

Does setting a GDB breakpoint manually on "mvm_bp" work?

> I'm investigating but just in case someone has already stumbled over that !
>

$ export MVM_GDBTRACE=-
$ xenoscope ...
(run the simulation)

The transactions between the IDE and GDB should be dumped on the screen; 
please send this output to me off-list. TIA,

> Thanks.
> 
> --
> Bruno Rouchouse
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

