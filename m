MIME-Version: 1.0
Date: Tue, 13 Jan 2015 18:01:54 +0100
Message-ID: <CAPozGfnFbPgfhi-ennhT2Ba=HJqs25W3WWVewXjBVbo87D81iQ@mail.gmail.com>
From: John Sini <jhnsini@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Negative latencies
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,


I was trying to boot linux with Xenomai on the Zedboard from Xilinx. When I
run the latency test I get negative values. I tried to calibrate my system
by running the following
echo 1 > /proc/xenomai/latency


But then when I run

cat latency - I get 0. I also get 0 if I put 2 or 3ns. If I put 4 i.e.

echo 4 > /proc/xenomai/latency and then do:

cat latency - I get 3.

Is there a possibility to calibrate my system to 1ns? Can the calibration
be done without echo 1 > /proc/xenomai/latency somehow in latency.c. Before
doing any calibration latency that I get is 9498.

Thanks,
John
