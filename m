Date: Wed, 31 Jan 2007 21:28:42 -0800 (PST)
From: poornima r <rpoornar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <79744.96382.qm@domain.hid>
Subject: [Adeos-main] switchbench tests with IPIPE tracer disabled
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi,

I was able to run latency and switchbench tests on
MPC860 board with IPIPE tracer feature
enabled/disabled.
Interrupt & scheduling Latencies and switching
latencies (with IPIPE tracer option disabled) were
having lower values when compared to latency values
with IPIPE tracer enabled. 
cyclictest test results were same with or without
IPIPE tracer enabled. 
Is this reduced context switching latency in
switchbench test due to timer interrupt?  

Thanks,
Poornima





 
____________________________________________________________________________________
TV dinner still cooling? 
Check out "Tonight's Picks" on Yahoo! TV.
http://tv.yahoo.com/

