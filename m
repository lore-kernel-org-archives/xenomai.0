Date: Sun, 28 Feb 2021 09:17:19 -0300
From: Gabriel Dinse <gabriel_dinse@hotmail.com>
Subject: GPIO interrupt reading timeout
Message-ID: <SN6PR08MB5661EE942B37DBEF57E8272F939B9@SN6PR08MB5661.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I currently have a loop rt_task for reading interrupts on a GPIO pin of 
my raspberry pi.

I'm using:
ret = read(pin, &value, sizeof(value));

but I don't want it to block forever, because my task should exit when 
there are not more interrupts to read. Can I use "select" for 
introducing a reading timeout on my loop and yet being "real-time"?

Thank you,
Gabriel Dinse

