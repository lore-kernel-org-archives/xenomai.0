Message-Id: <1FAD585D-B669-40CB-A779-0D1F496A3085@domain.hid>
From: Steven Seeger <steven.seeger@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Thu, 30 Apr 2009 18:09:51 -0400
Subject: [Xenomai-core] userspace applications and cache
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

If a userspace application running xenomai threads is large (1MB or  
so) then the code can't all live in cache on our puny 16kb instruction  
cache. Does the cache handling occur as needed in the primary domain  
or does it have to wait for Linux to handle it?

Thanks,
Steven


