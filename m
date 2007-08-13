Message-ID: <e39c9190708121709u765ab036w242c0c846c9c82f5@domain.hid>
Date: Mon, 13 Aug 2007 02:09:43 +0200
From: "juanba romance" <juanba.romance@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_47935_32908945.1186963783223"
Subject: [Xenomai-core] RTDM 82527 Xenomai driver
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_47935_32908945.1186963783223
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello, all,
I am currently developing a RTDM/xenomai driver for the CANbus chipset 82527
that i think it could have some interest
it has the next features:

   1. Specific management for the remote frames CANbus feasibility, it
   couple the real-time data bus flow with a user software feedback to
   handshake remote frames and update mailbox callback for the auto-replied
   messages
   2. Transparent use to push/suck data from the driver using a common
   data format
   3. Capability to push a bunch of CANbus messages in a single system
   call. The bunch is copied to a kernel domain ring buffer to guarantee low
   latencies at the user side. A specific kernel thread  sucks the ring pushing
   the user request into the chipset
   4. Driver readout using a native RT message queue where the control
   and data flow is published
   5. Multichipset capabilities, right now a commercial PC104 board with
   two devices is used. The on board CPU is a SBC VIA C3 1GHz processor
   softwared with the stack xenomai-2.3,1/vanilla-2.6.20-15/Adeos-
   ipipe-1.7-03
   6. board monitoring through the /proc file system entry
   7. Local Data Transfers controlled with RT-alarms
   8. Virtual support to check applications/driver usage/design, right
   now only the chipset is virtualised, but plans to have network transactions
   are on going
   9. ISR hardware optimizations focused on the network readout to
   gurantee low latencies
   10. Easy porting to other i82527 based on boards
   11. Full transmission operation handling the 16 message object set

We have in plan also

   1. Capabilities to filtering/masking the incoming flow at the driver
   stage allowing that the same context, using the "xenomai nomenclature" feed
   specific threads using some kind of binding/configuration process. This is
   an open issue cause i don't have a clear approach to follow..
   2. can-festival coupling

I think this is the full picture, i look forward..

Best regards..

------=_Part_47935_32908945.1186963783223
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello, all,<br>I am currently developing a RTDM/xenomai driver for the CANbus chipset 82527 that i think it could have some interest <br>it has the next features:<br><ol><li>Specific management for the remote frames CANbus feasibility, it couple the real-time data bus flow with a user software feedback to handshake remote frames and update mailbox callback for the auto-replied messages
<br>
</li><li>Transparent use to push/suck data from the driver using a common data format</li><li>Capability to push a bunch of CANbus messages in a single system call. The bunch is copied to a kernel domain ring buffer to guarantee low latencies at the user side. A specific kernel thread&nbsp; sucks the ring pushing the user request into the chipset 
<br>
</li><li>Driver readout using a native RT message queue where the control and data flow is published<br></li><li>Multichipset capabilities, right now a commercial PC104 board with two devices is used. The on board CPU is a SBC VIA C3 1GHz processor  softwared with the stack 
xenomai-2.3,1/vanilla-2.6.20-15/Adeos-ipipe-1.7-03 <br></li><li>board monitoring through the /proc file system entry</li><li>Local Data Transfers controlled with RT-alarms</li><li>Virtual support to check applications/driver usage/design, right now only the chipset is virtualised, but plans to have network transactions are on going
</li><li>ISR hardware optimizations focused on the network readout to gurantee low latencies<br></li><li>Easy porting to other i82527 based on boards</li><li>Full transmission operation handling the 16 message object set
</li></ol>We have in plan also<br><ol><li>
Capabilities to filtering/masking the incoming flow at the driver stage allowing that the same context, using the &quot;xenomai nomenclature&quot; feed specific threads using some kind of binding/configuration process. This is an open issue cause i don&#39;t have a clear approach to follow.. 
</li><li>can-festival coupling<br></li></ol>I think this is the full picture, i look forward..<br><br>Best regards..<br><br>

------=_Part_47935_32908945.1186963783223--

