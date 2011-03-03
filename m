Date: Thu, 03 Mar 2011 18:30:44 -0000 (UTC)
From: =?utf-8?B?0JTQtdC90LjRgSDQm9Cw0YLRi9GI0LXQsg==?= <latyshev@domain.hid>
Message-ID: <e9120c91-7bfe-489f-a80d-16e2bfdec46c@domain.hid>
In-Reply-To: <9d74726e-8787-47c2-b138-a07a1164380f@domain.hid>
Content-Type: multipart/alternative;
	boundary="=_cc86701d-f391-417e-ad73-a53d079b344b"
MIME-Version: 1.0
Subject: [Xenomai-core] 'cannot map MAYDAY page' on blackfin
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--=_cc86701d-f391-417e-ad73-a53d079b344b
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi All. 
I am trying to run xenomai on blackfin ADZS-BF537-EZLITE board, but I'm getting an error when trying to execute any test programs like arith, clocktest etc. 


Software versions: 
linux-2.6.35.7 
xenomai-2.5.5.2 


example: 


# /usr/xenomai/bin/arith 
Xenomai: binding failed: Cannot allocate memory. 


# dmesg | tail -5 

[ 7.288690] PHY: 0:01 - Link is Up - 100/Full 
[ 7.502574] Looking up port of RPC 100005/1 on 192.168.4.9 
[ 7.593737] VFS: Mounted root (nfs filesystem) on device 0:11. 
[ 7.601396] Freeing unused kernel memory: 104k freed 
[ 300.787988] Xenomai: arith[330] cannot map MAYDAY page 


All happens in root console. 


I found that the error returns from the function validate_mmap_request when the flag BDI_CAP_MAP_DIRECT is checked in 
file->f_mapping->backing_dev_info->capabilities while mapping memory in map_mayday_page. Looks like this flag must be set for /dev/rtheap, but it's not. 
Is it bug on NOMMU system or maybe my fault? I've build kernel and system as explained in README.INSTALL. 














--=_cc86701d-f391-417e-ad73-a53d079b344b
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head><style type='text/css'>p { margin: 0; }</style></head><body><div style='font-family: Times New Roman; font-size: 12pt; color: #000000'><font class="Apple-style-span" size="3">Hi All.</font><div style="color: rgb(0, 0, 0); font-family: 'Times New Roman'; font-size: 12pt; ">I am trying to run xenomai on blackfin ADZS-BF537-EZLITE board, but I'm getting an error when trying to execute any test programs like arith, clocktest etc.</div><div style="color: rgb(0, 0, 0); font-family: 'Times New Roman'; font-size: 12pt; "><br></div><div style="color: rgb(0, 0, 0); font-family: 'Times New Roman'; font-size: 12pt; ">Software versions:</div><div style="color: rgb(0, 0, 0); font-family: 'Times New Roman'; font-size: 12pt; ">linux-2.6.35.7</div><div style="color: rgb(0, 0, 0); font-family: 'Times New Roman'; font-size: 12pt; ">xenomai-2.5.5.2</div><div style="color: rgb(0, 0, 0); font-family: 'Times New Roman'; font-size: 12pt; "><br></div><div style="color: rgb(0, 0, 0); font-
 family: 'Times New Roman'; font-size: 12pt; ">example:</div><div><br></div><div># /usr/xenomai/bin/arith</div><div>Xenomai: binding failed: Cannot allocate memory.</div><div><br></div><div># dmesg | tail -5</div><div><div>[ &nbsp; &nbsp; &nbsp;7.288690] PHY: 0:01 - Link is Up - 100/Full</div><div>[ &nbsp; &nbsp; &nbsp;7.502574] Looking up port of RPC 100005/1 on 192.168.4.9</div><div>[ &nbsp; &nbsp; &nbsp;7.593737] VFS: Mounted root (nfs filesystem) on device 0:11.</div><div>[ &nbsp; &nbsp; &nbsp;7.601396] Freeing unused kernel memory: 104k freed</div></div><div>[ &nbsp;300.787988] Xenomai: arith[330] cannot map MAYDAY page</div><div><br></div><div>All happens in root console.</div><div><br></div><div>I found that the error returns from the function validate_mmap_request when the flag BDI_CAP_MAP_DIRECT is checked in</div><div><meta http-equiv="content-type" content="text/html; charset=utf-8">file-&gt;f_mapping-&gt;backing_dev_info-&gt;capabilities while mapping memory in ma
 p_mayday_page. Looks like this flag must be set for /dev/rtheap, but it's not.</div><div>Is it bug on NOMMU system or maybe my fault? I've build kernel and system as explained in README.INSTALL.</div><div><br></div><div><br></div><div><br></div><div><br></div><div><br></div><div><br></div><div><br></div></div></body></html>
--=_cc86701d-f391-417e-ad73-a53d079b344b--

