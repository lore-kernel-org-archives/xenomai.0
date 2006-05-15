From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Mon, 15 May 2006 22:40:15 +0200
References: <44689BBE.1000304@domain.hid>
In-Reply-To: <44689BBE.1000304@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vcOaEq7dFNO/W2I"
Message-Id: <200605152240.15620.berlemont.hauw@domain.hid>
Subject: [Xenomai-core] Re: LTTng intergration roadmap
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: ROSSIER Daniel <Daniel.Rossier@domain.hid>, xenomai-core <xenomai@xenomai.org>

--Boundary-00=_vcOaEq7dFNO/W2I
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

> the need for a high-level tracing tool constantly increases with the
> growing code base of Xenomai applications.
>
> Yesterday I started a short discussion with Alexis about the status of
> his LTTng combo patch, the Xenomai integration, and the advances of
> LTTng itself. But there are certainly more people interested in this
> topic and may contribute ideas, comments, or even concrete code.
>
> Daniel, you once said that some of your students would start to work on
> this topic. In which domain precisely, more at patch level or rather on
> tools? What is the scheduled beginning and/or deadline for this thesis?
>
> Moreover, does anyone on this list recently tried LTTng on standard
> Linux? Can we consider it reasonably stable and usable? One new thing
> about LTTng internals which Alexis brought up were changes in the custom
> tracing event interface. As this is a rather crucial point with respect
> to the Xenomai instrumentation, we certainly do not want to change it
> back and forth until LTTng stabilises.

Here is a little quotation from the LTTng Quickstart guide, I used it to 
define the LTT events for Xenomai:

* Add new events to the kernel with genevent

su -
cd /usr/local/share/LinuxTraceToolkitViewer/facilities
cp process.xml yourfacility.xml
  * edit yourfacility.xml to fit your needs.
cd /tmp
/usr/local/bin/genevent /usr/local/share/LinuxTraceToolkitViewer/facilities/yourfacility.xml
cp ltt-facility-yourfacility.h ltt-facility-id-yourfacility.h \
         /usr/src/linux-2.6.16-lttng-0.x.xx8/include/linux/ltt
cp ltt-facility-loader-yourfacility.c ltt-facility-loader-yourfacility.h \
         /usr/src/linux-2.6.16-lttng-0.x.xx/ltt
  * edit the kernel file you want to instrument
    - Add #include <linux/ltt/ltt-facility-yourfacility.h> at the beginning
      of the file.
    - Add a call to the tracing functions. See their names and parameters in
      /usr/src/linux-2.6.16-lttng-0.x.xx/include/linux/ltt/ltt-facility-yourfacility.h

So, In order to test the combo patch adeos + LTTng I made:
-> I wrote xenomai.xml (cf. attached file) which defines all the Xeno-LTT 
events;
-> I used genevent so as to generate the sources and the headers relative with 
my events;
-> Instead of copying them in the kernel, I integrated the sources in Xenomai. 
I was considering that the Xeno events was independant from Linux. 

As a matter of fact, the last point should be rethought as the Xeno build 
procedure is now integrated in the kernel. 

Things are simpler now, we could create an "I-pipe aware LTTng" patch which 
could contain :
-> the modifications in Relayfs (for a proper functioning with Adeos);
-> the LTTng core stuff adapted for Adeos (not much work to do on this part);
-> the Xenomai events in include/linux/ltt, and the loading code in ...

This patch would be applied after the I-pipe patch (in the same way as the 
I-pipe tracer patch). So there would be no need to make combo patches, an 
arch-independant additionnal patch would be easier to maintain.

What do you think of that ?

Eventually, concerning LTTng stabilisation status, I had a look a their 
mailing-list (I am lurking on it since the beginning of LTTng) and at their 
roadmap: starting from now, their TODO list contains integration and ports, 
therefore undertaking an integration of LTTng with Xenomai (rigth now or next 
month) does not seem too risky, does it?

Jan, 

Yesterday I told you that that Matthieu Desnoyers proposed a new way of 
defining custom events since my last patch proposal. That was false: MD 
proposed his new method before my patch proposal; however, the genevent 
features kept on evolving. Sorry that was not very clear.

Best regards.

Alexis.



--Boundary-00=_vcOaEq7dFNO/W2I
Content-Type: text/plain;
  charset="iso-8859-15";
  name="xenomai.xml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xenomai.xml"

<facility name=xenomai>
  <description>The Xenomai facility has events related to Xenomai process execution.</description>	

  <event name=xeno_timer_tick>
    <description>Xenomai timer tick</description>
    <field name="runthread"><string/></field>
  </event>

  <event name=xeno_irq_enter>
    <description>Xenomai irq enter</description>
    <field name="irq"><uint size=4/></field>
  </event>

  <event name=xeno_irq_exit>
    <description>Xenomai irq exit</description>
    <field name="irq"><uint size=4/></field>
  </event>

  <event name=xeno_resched>
    <description>Xenomai reschedule event</description>
  </event>

  <event name=xeno_smpsched>
    <description>Xenomai smp schedule event</description>
  </event>

  <event name=xeno_fastsched>
    <description>Xenomai fast schedule event</description>
  </event>

  <event name=xeno_switch>
    <description>Xenomai process switch</description>
    <field name="from"><string/></field>
    <field name="to"><string/></field>
  </event>

  <event name=xeno_fault>
    <description>Xenomai fault</description>
    <field name="thread"><string/></field>
    <field name="location"><pointer/></field>
    <field name="trap"><uint size=4/></field>
  </event>

  <event name=xeno_callout>
    <description>Xenomai callout</description>
    <field name="type"><string/></field>
    <field name="thread"><string/></field>
  </event>

  <event name=xeno_finalize>
    <description>Xenomai finalize</description>
    <field name="from"><string/></field>
    <field name="to"><string/></field>
  </event>

  <event name=xeno_thread_init>
    <description>Xenomai thread init</description>
    <field name="thread"><string/></field>
    <field name="flags"><uint size=4/></field>
  </event>

  <event name=xeno_thread_start>
    <description>Xenomai thread start</description>
    <field name="thread"><string/></field>
  </event>

  <event name=xeno_thread_restart>
    <description>Xenomai thread restart</description>
    <field name="thread"><string/></field>
  </event>

  <event name=xeno_thread_delete>
    <description>Xenomai thread delete</description>
    <field name="thread"><string/></field>
  </event>

  <event name=xeno_thread_suspend>
    <description>Xenomai thread start</description>
    <field name="thread"><string/></field>
    <field name="mask"><uint size=4/></field>
    <field name="timeout"><uint size=4/></field>
    <field name="wchan"><pointer/></field>
  </event>

  <event name=xeno_thread_resume>
    <description>Xenomai thread resume</description>
    <field name="thread"><string/></field>
    <field name="mask"><uint size=4/></field>
  </event>

  <event name=xeno_thread_unblock>
    <description>Xenomai thread unblock</description>
    <field name="thread"><string/></field>
    <field name="status"><uint size=4/></field>
  </event>

  <event name=xeno_thread_renice>
    <description>Xenomai thread renice</description>
    <field name="thread"><string/></field>
    <field name="prio"><int size=4/></field>
  </event>

  <event name=xeno_cpu_migrate>
    <description>Xenomai CPU migrate</description>
    <field name="thread"><string/></field>
    <field name="cpu"><int size=4/></field>
  </event>

  <event name=xeno_sigdispatch>
    <description>Xenomai signal dispatch</description>
    <field name="thread"><string/></field>
    <field name="sigpend"><int size=4/></field>
  </event>

  <event name=xeno_thread_begin>
    <description>Xenomai thread begin</description>
    <field name="thread"><string/></field>
  </event>

  <event name=xeno_sleepon>
    <description>Xenomai sleepon</description>
    <field name="thread"><string/></field>
    <field name="sync"><pointer/></field>
  </event>

  <event name=xeno_wakeup1>
    <description>Xenomai wakeup1</description>
    <field name="thread"><string/></field>
    <field name="sync"><pointer/></field>
  </event>

  <event name=xeno_wakeupx>
    <description>Xenomai wakeupx</description>
    <field name="thread"><string/></field>
    <field name="sync"><pointer/></field>
  </event>

  <event name=xeno_syncflush>
    <description>Xenomai syncflush</description>
    <field name="sync"><pointer/></field>
    <field name="reason"><uint size=4/></field>
  </event>

  <event name=xeno_syncforget>
    <description>Xenomai syncforget</description>
    <field name="thread"><string/></field>
    <field name="sync"><pointer/></field>
  </event>

  <event name=xeno_lohandler>
    <description>Xenomai lohandler</description>
    <field name="type"><int size=4/></field>
    <field name="task"><string/></field>
    <field name="pid"><int size=4/></field>
  </event>

  <event name=xeno_modsw1>
    <description>Xenomai modsw1</description>
    <field name="thread"><string/></field>
  </event>

  <event name=xeno_modex1>
    <description>Xenomai modex1</description>
    <field name="thread"><string/></field>
  </event>

  <event name=xeno_modsw2>
    <description>Xenomai modsw2</description>
    <field name="thread"><string/></field>
  </event>

  <event name=xeno_modex2>
    <description>Xenomai modex2</description>
    <field name="thread"><string/></field>
  </event>

  <event name=xeno_shadowmap>
    <description>Xenomai shadow map</description>
    <field name="thread"><string/></field>
    <field name="pid"><int size=4/></field>
    <field name="prio"><int size=4/></field>
  </event>

  <event name=xeno_shadowunmap>
    <description>Xenomai shadow unmap</description>
    <field name="thread"><string/></field>
    <field name="pid"><int size=4/></field>
  </event>

  <event name=xeno_shadowstart>
    <description>Xenomai shadow start</description>
    <field name="thread"><string/></field>
  </event>

  <event name=xeno_syscall>
    <description>Xenomai syscall</description>
    <field name="thread"><string/></field>
    <field name="skin"><int size=4/></field>
    <field name="call"><int size=4/></field>
  </event>

  <event name=xeno_shadowexit>
    <description>Xenomai shadow exit</description>
    <field name="thread"><string/></field>
  </event>

  <event name=xeno_thrsetmode>
    <description>Xenomai shadow unmap</description>
    <field name="thread"><string/></field>
    <field name="clrmask"><uint size=4/></field>
    <field name="setmask"><uint size=4/></field>
  </event>

  <event name=xeno_rdrotate>
    <description>Xenomai ready rotate</description>
    <field name="thread"><string/></field>
    <field name="prio"><int size=4/></field>
  </event>

  <event name=xeno_rractivate>
    <description>Xenomai RR on</description>
    <field name="quantum"><uint size=8/></field>
  </event>

  <event name=xeno_rrdeactivate>
    <description>Xenomai RR off</description>
  </event>

  <event name=xeno_timeset>
    <description>Xenomai set time</description>
    <field name="newtime"><uint size=8/></field>
  </event>

  <event name=xeno_addhook>
    <description>Xenomai add hook</description>
    <field name="type"><int size=4/></field>
    <field name="routine"><pointer/></field>
  </event>

  <event name=xeno_removehook>
    <description>Xenomai remove hook</description>
    <field name="type"><int size=4/></field>
    <field name="routine"><pointer/></field>
  </event>

  <event name=xeno_thrperiodic>
    <description>Xenomai thread speriod</description>
    <field name="thread"><string/></field>
    <field name="idate"><uint size=8/></field>
    <field name="period"><uint size=8/></field>
  </event>

  <event name=xeno_thrwait>
    <description>Xenomai thread wperiod</description>
    <field name="thread"><string/></field>
  </event>

  <event name=xeno_tmstart>
    <description>Xenomai start timer</description>
    <field name="ticks"><uint size=4/></field>
  </event>

  <event name=xeno_tmstop>
    <description>Xenomai stop timer</description>
  </event>

  <event name=xeno_mark>
    <description>Xenomai mark</description>
    <field name="mark"><string/></field>
  </event>

  <event name=xeno_watchdog>
    <description>Xenomai watchdog</description>
    <field name="runthread"><string/></field>
  </event>

</facility>

--Boundary-00=_vcOaEq7dFNO/W2I--


