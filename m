From: Johannes Holtz <johannes.holtz@compador.de>
Subject: EMSGSIZE whith send on RTcan socket
Message-ID: <057b4634-3127-3872-922d-f690c04c4bed@compador.de>
Date: Fri, 5 Apr 2019 11:31:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

While sending a multitude of SDOs via RTcan I get some EMSGSIZE errors. 
There is no obvious pattern to the occurrences and most of the messages 
are sent OK. I checked the parameters that I use and each frame is send 
with the same size ( sizeof(can_frame_t) ) and each frame has a dlc of 8.

So my question is in which specific situation is the EMSGSIZE issued. 
The man page entry wasn't very helpful.


Cheers

Johannes



