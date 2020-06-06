dialog(name: '$$$/AdobePlugin/Shared/Statistics/StatDialog=Image Stack Statistics')
{
	group(placement: place_row)
	{
		group(placement: place_column)
		{
			group(placement: place_row)
			{
				group(margin_top: 3, placement: place_column, vertical: align_top)				{					static_text(name: '$$$/AdobePlugin/Shared/Statistics/StatOperation=&Choose Stack Mode: ');
				}
				popup_menu(resource_id: 127, view_id: '_operation', width: 232, height: 22);
			}
			cluster(name: '$$$/AdobePlugin/Shared/Exposuremerge/FileSelectDialog/SourceFiles=Source Files')
			{
				group(margin_top: 4, placement: place_column)
				{
					static_text(height: 34, horizontal: align_left, max_width: 340, multiline: true, name: '$$$/AdobePlugin/Shared/Statistics/FileSelectDialog/ChooseTwo=Choose two or more files to compute the statistics operation on.', vertical: align_center, view_id: '_intro', width: 320);
					group(horizontal: align_left, placement: place_row)
					{
						group(margin_top: 3, placement: place_column, vertical: align_top)						{							static_text(name: '$$$/AdobePlugin/Shared/Exposuremerge/FileSelectDialog/Use=&Use:', vertical: align_top);
						}
						group(horizontal: align_left, placement: place_column)
						{
							popup_menu(horizontal: align_left, resource_id: 100, view_id: '_source', width: 214, height: 22);
							group(horizontal: align_left, placement: place_row)
							{
								listbox(height: 152, horizontal: align_left, item_id: 'multiselect: true', view_id: '_fileList', width: 214);
								group(horizontal: align_left, placement: place_column, vertical: align_top)
								{
									button(horizontal: align_fi